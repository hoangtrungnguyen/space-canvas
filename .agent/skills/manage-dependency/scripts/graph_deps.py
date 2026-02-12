
import os
import re
import sys
import networkx as nx

def get_imports(file_path):
    """Parses a dart file and returns a list of package imports."""
    imports = []
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            # Matches: import 'package:my_app/...'
            # Attempts to capture generic package structure.
            # Adjust regex to match your project's name if needed, or capturing all package imports.
            # Here we try to capture all package imports for graph completeness within the project context,
            # but ideally we want to focus on internal dependencies.
            matches = re.findall(r"import\s+['\"]package:([^/]+)/([^'\"]+)['\"]", content)
            for pkg, path in matches:
                # We assume the current package is named 'ideascape' based on pubspec.yaml
                if pkg == 'ideascape': 
                    imports.append(path)
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
    return imports

def build_graph(root_dir):
    """Walks the directory and builds a dependency graph."""
    G = nx.DiGraph()
      
    for root, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith(".dart"):
                full_path = os.path.join(root, file)
                # Convert to relative path matching import structure
                rel_path = os.path.relpath(full_path, root_dir).replace(os.sep, '/')
                  
                G.add_node(rel_path)
                  
                imports = get_imports(full_path)
                for imp in imports:
                    G.add_edge(rel_path, imp)
    return G

def analyze_graph(G):
    """Analyzes the graph for cycles and high-coupling."""
    print(f"Total Files: {G.number_of_nodes()}")
    print(f"Total Dependencies: {G.number_of_edges()}")
      
    # Cycle Detection
    try:
        cycles = list(nx.simple_cycles(G))
        if cycles:
            print(f"\n Found {len(cycles)} circular dependencies:")
            for cycle in cycles:
                print(f"  - {' -> '.join(cycle)}")
        else:
            print("\n No circular dependencies found.")
    except ImportError:
        print("\n Cycle detection skipped (networkx version might be old or missing simple_cycles).")
          
    # Coupling Analysis
    print("\nTop 5 Most Coupled Files (In-Degree):")
    # sorted returns list of (node, degree)
    in_degrees = sorted(G.in_degree, key=lambda x: x[1], reverse=True)[:5]
    for node, degree in in_degrees:
        print(f"  - {node}: {degree} importers")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python graph_deps.py <lib_directory>")
        sys.exit(1)
          
    root_dir = sys.argv[1]
    graph = build_graph(root_dir)
    analyze_graph(graph)
