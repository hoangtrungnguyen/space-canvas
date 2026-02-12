---
name: ensure-bloc-integrity
description: Ensure BLoC layer integrity by enforcing strict separation of concerns.
allowed-tools: Read, Write, Audit, Edit, Glob, Bash, Git
---
# **BLoC Integrity Skill**

## **Objective**

Maintain strict separation of concerns within the BLoC layer, ensuring independence from UI and Data layers.

## **Constraints & Rules**

1. **Layer Isolation**:  
   * BLoCs MUST import from domain/usecases or domain/repositories.  
   * BLoCs MUST NOT import from data/datasources or package:http.  
   * BLoCs MUST NOT import package:flutter/material.dart (except for strictly visual data types if unavoidable, but prefer VM conversion in UI).  
2. **State Purity**:  
   * State classes must be immutable (use freezed or Equatable).  
   * State must not hold Context, AnimationController, or TextEditingController.  
3. **Event Handling**:  
   * Events should be verb-based (e.g., CanvasPanStarted, not SetX).  
   * Complex event handlers must be split into separate helper methods or transformers.

## **Refactoring Protocol**

If a BLoC violates these rules:

1. Extract the logic into a UseCase.  
2. Move the dependency to the UseCase constructor.  
3. Inject the UseCase into the BLoC.

## **Tools**

### **scripts/audit_imports.dart**
Scans `*_bloc.dart` and `*_cubit.dart` files to identify illegal imports.

**Usage:**
```bash
dart scripts/audit_imports.dart [directory]
```

## **Resources**

### **resources/clean_bloc_template.dart**
A template file demonstrating the Feature-First structure using the flutter_bloc and freezed packages.
