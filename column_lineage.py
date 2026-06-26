"""
dbt Column Lineage Generator
Reads target/manifest.json and traces column lineage by matching column names
across parent→child model hops using the manifest's parent_map.
"""

import json
import argparse
from collections import defaultdict
from pathlib import Path


# ---------------------------------------------------------------------------
# Loading helpers
# ---------------------------------------------------------------------------

def load_manifest(path: str) -> dict:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def get_all_nodes(manifest: dict) -> dict:
    """Return a flat dict of unique_id → node for models + sources."""
    nodes = {}
    for uid, node in manifest.get("nodes", {}).items():
        if node.get("resource_type") in ("model", "seed", "snapshot"):
            nodes[uid] = node
    for uid, node in manifest.get("sources", {}).items():
        nodes[uid] = node
    return nodes


# ---------------------------------------------------------------------------
# Core lineage builder
# ---------------------------------------------------------------------------

def build_column_lineage(manifest: dict) -> list[dict]:
    """
    For every (parent, child) edge in parent_map, find columns that appear
    in both parent and child by name.  Returns a list of lineage records:
        {
          "upstream_node":   "model.pkg.stg_orders",
          "upstream_model":  "stg_orders",
          "upstream_col":    "ORDER_ID",
          "downstream_node": "model.pkg.fct_orders",
          "downstream_model":"fct_orders",
          "downstream_col":  "ORDER_ID",
        }
    """
    nodes = get_all_nodes(manifest)
    parent_map: dict[str, list[str]] = manifest.get("parent_map", {})

    lineage: list[dict] = []

    for child_uid, parents in parent_map.items():
        child = nodes.get(child_uid)
        if child is None:
            continue

        child_cols = {c.upper() for c in child.get("columns", {}).keys()}
        if not child_cols:
            continue

        for parent_uid in parents:
            parent = nodes.get(parent_uid)
            if parent is None:
                continue

            parent_cols = {c.upper() for c in parent.get("columns", {}).keys()}
            shared = child_cols & parent_cols

            for col in sorted(shared):
                lineage.append({
                    "upstream_node":    parent_uid,
                    "upstream_model":   parent.get("name", parent_uid),
                    "upstream_col":     col,
                    "downstream_node":  child_uid,
                    "downstream_model": child.get("name", child_uid),
                    "downstream_col":   col,
                })

    return lineage


# ---------------------------------------------------------------------------
# Output formatters
# ---------------------------------------------------------------------------

def print_table(lineage: list[dict]) -> None:
    if not lineage:
        print("No column lineage found (check that your models have columns defined in schema.yml).")
        return

    col_w = 30
    print(
        f"{'UPSTREAM MODEL':<{col_w}} {'UPSTREAM COL':<{col_w}} "
        f"{'DOWNSTREAM MODEL':<{col_w}} {'DOWNSTREAM COL':<{col_w}}"
    )
    print("-" * (col_w * 4 + 3))
    for row in lineage:
        print(
            f"{row['upstream_model']:<{col_w}} {row['upstream_col']:<{col_w}} "
            f"{row['downstream_model']:<{col_w}} {row['downstream_col']:<{col_w}}"
        )
    print(f"\n{len(lineage)} column lineage edges found.")


def print_tree(lineage: list[dict], target_model: str | None = None) -> None:
    """Group by downstream model and show upstream sources per column."""
    # downstream_model → downstream_col → list of (upstream_model, upstream_col)
    tree: dict[str, dict[str, list[tuple[str, str]]]] = defaultdict(lambda: defaultdict(list))

    for row in lineage:
        if target_model and row["downstream_model"] != target_model:
            continue
        tree[row["downstream_model"]][row["downstream_col"]].append(
            (row["upstream_model"], row["upstream_col"])
        )

    if not tree:
        print("No lineage found for the specified model.")
        return

    for model, cols in sorted(tree.items()):
        print(f"\n{model}")
        for col, sources in sorted(cols.items()):
            print(f"  └─ {col}")
            for src_model, src_col in sources:
                print(f"       ← {src_model}.{src_col}")


def save_json(lineage: list[dict], out_path: str) -> None:
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(lineage, f, indent=2)
    print(f"Saved {len(lineage)} lineage edges to {out_path}")


# ---------------------------------------------------------------------------
# Column-centric lookup helpers
# ---------------------------------------------------------------------------

def where_is_column_used(lineage: list[dict], column_name: str) -> None:
    """Print everywhere a column name appears across the DAG."""
    col = column_name.upper()
    hits = [r for r in lineage if r["upstream_col"] == col or r["downstream_col"] == col]
    if not hits:
        print(f"Column '{col}' not found in any lineage edge.")
        return
    print(f"\nLineage edges involving column '{col}':")
    for row in hits:
        print(f"  {row['upstream_model']}.{row['upstream_col']}  →  {row['downstream_model']}.{row['downstream_col']}")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args():
    p = argparse.ArgumentParser(description="Generate dbt column lineage from manifest.json")
    p.add_argument(
        "--manifest", default="target/manifest.json",
        help="Path to dbt manifest.json (default: target/manifest.json)"
    )
    p.add_argument(
        "--format", choices=["table", "tree", "json"], default="tree",
        help="Output format (default: tree)"
    )
    p.add_argument(
        "--model", default=None,
        help="Filter tree output to a specific downstream model name"
    )
    p.add_argument(
        "--column", default=None,
        help="Show all lineage edges that involve a specific column name"
    )
    p.add_argument(
        "--out", default=None,
        help="Write JSON output to this file (only used with --format=json)"
    )
    return p.parse_args()


def main():
    args = parse_args()

    manifest_path = Path(args.manifest)
    if not manifest_path.exists():
        raise FileNotFoundError(f"manifest.json not found at: {manifest_path}")

    print(f"Loading {manifest_path} ...")
    manifest = load_manifest(str(manifest_path))
    lineage = build_column_lineage(manifest)

    if args.column:
        where_is_column_used(lineage, args.column)
        return

    if args.format == "table":
        print_table(lineage)
    elif args.format == "tree":
        print_tree(lineage, target_model=args.model)
    elif args.format == "json":
        out = args.out or "column_lineage.json"
        save_json(lineage, out)


if __name__ == "__main__":
    main()
