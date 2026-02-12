---
name: manage-dependency
---
# **Dependency Management Skill**

## **Objective**

Ensure the directed acyclic graph (DAG) of project dependencies remains acyclic and loosely coupled.

## **Protocol**

1. **Pre-Change Analysis**: Before introducing a new import, run `scripts/graph_deps.py` to check if the target module already depends on the source module (indirectly).  
2. **Cycle Detection**: If a cycle is detected, halt generation and propose an "Interface Extraction" refactor.  
3. **Layer Enforcement**:  
   * Core cannot depend on Features.  
   * Feature A cannot depend on Feature B directly (Must use Core interfaces or Deep Link routing).

## **Strategies**

* **Inversion of Control**: If A needs B, but B needs A, define an interface in A that B implements.  
* **Barrel Files**: Avoid importing `file.dart` directly if `a_library.dart` exists, but beware of importing the barrel file if it re-exports the world (tree shaking issues).

## **Tools**

### **scripts/graph_deps.py**
A Python script using `networkx` to visualize and analyze the dependency graph.

**Usage:**
```bash
python3 scripts/graph_deps.py [lib_directory]
```

## **Resources**

### **resources/architecture_layers.mermaid**
A Mermaid diagram defining the allowed flow of dependencies.
