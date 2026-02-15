# **Architectural Intelligence: Operationalizing Agent Skills for High-Performance Flutter Canvas Applications**

## **1\. Introduction: The Agentic Shift in Software Engineering**

The contemporary landscape of software engineering is undergoing a fundamental transformation driven by the emergence of autonomous Large Language Model (LLM) agents. We are transitioning from an era of "prompt engineering"—where developers guide stochastic models through singular, isolated tasks—to an era of "agentic engineering." In this new paradigm, AI systems act as semi-autonomous entities capable of planning, tool execution, and self-correction. However, the efficacy of these agents is not inherent; it is strictly bounded by the context and capabilities provided to them.

General-purpose coding agents often fail when confronted with specialized, high-performance environments. A generic agent understands the syntax of Dart but lacks the nuanced understanding of the Flutter rendering pipeline required to optimize a complex drawing application. It knows how to write a class but may not respect the strict boundaries of Clean Architecture or the specific state management patterns of the Business Logic Component (BLoC) library. When an agent unknowingly introduces a circular dependency or forces a full-screen repaint on every micro-interaction, it ceases to be an asset and becomes a source of technical debt.

To bridge this gap, we must treat "Agent Skills" as first-class architectural components. Just as we define interfaces for human developers, we must define **Skills**—modular, executable, and documented capabilities—that equip the agent with the specific knowledge and tools required to navigate a complex codebase.

This report details a comprehensive framework for architecting these skills within a Flutter Canvas project using BLoC. We propose a standardized .agent/skills/ directory structure that serves as the agent's external memory and toolbox. We explore the implementation of three critical skills—**Canvas Optimization**, **BLoC Integrity**, and **Dependency Management**—and outline "Research-First" strategies that prioritize deep analysis over hasty generation. This approach ensures that AI integration aligns with, rather than disrupts, rigorous engineering standards.1

## ---

**2\. The Theoretical Framework of Agent Skills**

An "Agent Skill" is not merely a prompt. It is a encapsulated unit of capability that combines declarative knowledge (what to do) with procedural knowledge (how to do it) and executable tooling (the means to do it). In the context of a Flutter application, where performance constraints are unforgiving and architectural purity is paramount, these skills must be formal and deterministic.

### **2.1 The Persistence of Context**

LLMs suffer from limited context windows and ephemeral memory. A chat session is transient; once closed, the context is lost. To build an agent capable of maintaining a complex project over months, we must externalize its "long-term memory" into the file system. The .agent/skills/ directory structure acts as this persistent cortex.

By standardizing this structure, we achieve **Discoverability**. An agent, instructing itself to "optimize rendering," can deterministically locate .agent/skills/canvas\_optimization/ and load the relevant Standard Operating Procedures (SOPs) and tools. This eliminates the need for the human developer to paste massive documentation blocks into every prompt. It grounds the agent in the project's specific reality rather than its generic training data.4

### **2.2 The Anatomy of a Skill**

We define a rigorous folder structure for every skill to ensure consistency and machine-readability.

#### **2.2.1 The Manifest (SKILL.md)**

The SKILL.md file is the cognitive core of the skill. It is a Markdown document written specifically for the LLM to consume. It functions as a "System Prompt Extension," injecting domain-specific constraints and reasoning protocols into the model's context.

A robust Manifest must contain:

1. **Objective Definition**: A clear, non-ambiguous statement of what this skill achieves (e.g., "Detect and remediate excessive repaints in CustomPainter widgets").  
2. **The Reasoning Protocol**: A step-by-step "Chain of Thought" the agent must simulate. For example, "Before refactoring a painter, distinct phases of analysis must be performed: Identification, Impact Assessment, and Solution Hypothesis."  
3. **Strict Constraints**: "Negative Constraints" are often more valuable than positive instructions. For a BLoC project, this might be: "NEVER import a repository directly into a UI widget."  
4. **Tool Usage Guidelines**: Instructions on when and how to invoke the scripts located in the scripts/ subdirectory.

#### **2.2.2 The Toolbox (scripts/)**

Agents maximize their utility when they can interact with the environment. The scripts/ directory contains executable code—written in Dart, Python, or Bash—that the agent can invoke to gather ground-truth data.

For a Flutter project, these scripts leverage the **Dart Analyzer** and **abstract syntax tree (AST)** traversal to "see" the code structure without reading every file into the context window. An agent cannot "look" at a 50,000-line codebase, but it *can* run a script that reports "File X imports File Y" or "Class Z extends CustomPainter but lacks shouldRepaint." This capability transforms the agent from a text generator into a code analyst.5

#### **2.2.3 The Reference Library (resources/)**

The resources/ directory contains "Gold Standard" artifacts. These are static files—code templates, architectural diagrams (Mermaid), or simplified schema definitions—that the agent uses as targets for few-shot learning.

If the project uses the freezed package for immutable state, the resources/ folder should contain a perfect example of a freezed BLoC state. This prevents the agent from hallucinating generic Dart classes or outdated manual copyWith implementations. It forces the agent to mimic the project's established style.4

### **2.3 Directory Structure Overview**

The proposed structure for a Flutter project utilizing this framework appears as follows:

project\_root/

├──.agent/

│ ├── skills/

│ │ ├── canvas\_optimization/

│ │ │ ├── SKILL.md

│ │ │ ├── scripts/

│ │ │ │ └── analyze\_painters.dart

│ │ │ └── resources/

│ │ │ └── efficient\_painter\_pattern.dart

│ │ ├── bloc\_integrity/

│ │ │ ├── SKILL.md

│ │ │ ├── scripts/

│ │ │ │ └── audit\_imports.dart

│ │ │ └── resources/

│ │ │ └── feature\_bloc\_template.dart

│ │ └── dependency\_management/

│ │ ├── SKILL.md

│ │ ├── scripts/

│ │ │ └── graph\_deps.py

│ │ └── resources/

│ │ └── layer\_diagram.mermaid

├── lib/

│ ├── features/

│ ├── core/

│ └── main.dart

├── pubspec.yaml

└── analysis\_options.yaml

This explicit structure allows for modular governance. A senior engineer can review and update the SKILL.md for "BLoC Integrity" to reflect a new architectural decision (e.g., switching from get\_it to riverpod for DI), and the agent's behavior will update immediately across all future tasks without retraining.8

## ---

**3\. Deep Dive: The Flutter Canvas & BLoC Ecosystem**

To design effective skills, one must first deeply understand the domain. Flutter's rendering pipeline and the BLoC pattern's state propagation mechanism create a specific set of challenges that the agent must be equipped to handle.

### **3.1 The Rendering Pipeline and Performance**

Flutter does not use native OS widgets; it draws its own UI using the Skia graphics engine (and increasingly, Impeller). This provides pixel-perfect consistency but places the burden of performance optimization entirely on the developer code.

The pipeline consists of four primary phases:

1. **Build**: The Widget tree is constructed. This is lightweight.  
2. **Layout**: The RenderObject tree calculates sizes and positions.  
3. **Paint**: The RenderObjects record drawing commands into a Picture.  
4. **Composite**: The layers are rasterized and sent to the GPU.

In a Canvas-heavy application (e.g., a drawing tool, a charting library, or a game), the **Paint** phase is critical. A CustomPainter allows developers to issue low-level draw commands. However, without careful management, a simple state change can trigger a full repaint of the entire canvas, causing frame drops (jank).9

The agent needs to understand that **Widget Rebuilds** and **Canvas Repaints** are distinct. A widget can rebuild without repainting if the CustomPainter correctly implements shouldRepaint. Conversely, a widget might not rebuild, but an animation controller could trigger a repaint every frame.11

### **3.2 The BLoC Pattern in Clean Architecture**

The Business Logic Component (BLoC) pattern is the standard for separation of concerns in Flutter. It mediates between the Presentation Layer (UI) and the Domain Layer (Business Logic) using Streams.

* **Events**: Inputs to the BLoC (e.g., CanvasPanUpdated, ToolSelected).  
* **States**: Outputs from the BLoC (e.g., CanvasLoaded, DrawingInProgress).

In a Clean Architecture approach (specifically "Feature-First"), the project is divided into features (e.g., features/editor, features/pallette). Each feature contains its own BLoC.

The challenge for an AI agent is maintaining the purity of this flow. Agents trained on generic tutorials often introduce "God BLoCs"—massive classes that handle authentication, navigation, and canvas drawing simultaneously. Or, they might leak UI details (like BuildContext or TextEditingController) into the BLoC state, which violates the platform-agnostic nature of the pattern.13

### **3.3 The Intersection: BLoC-Driven Canvas**

Connecting BLoC to a CustomPainter introduces a specific synchronization challenge. The BLoC emits a state (e.g., a list of 10,000 points). The UI builds a CustomPaint widget. The CustomPainter draws the points.

If the BLoC emits a new state every time the user drags their finger (60 times a second), and the CustomPainter redraws all 10,000 points every time, the app will freeze. The agent must possess the skill to recognize this pattern and suggest optimizations like:

1. **RepaintBoundary**: Isolating the canvas from the rest of the UI.  
2. **Change Detection**: Using buildWhen in BlocBuilder to ignore irrelevant state changes.  
3. **Layering**: Splitting the drawing into a "static background" painter and a "dynamic active stroke" painter.10

## ---

**4\. Skill Implementation: Canvas Optimization**

The canvas\_optimization skill equips the agent to act as a graphics performance engineer. It focuses on the efficient use of the CustomPainter API and the Flutter rendering boundary system.

### **4.1 Manifest: SKILL.md**

The manifest for this skill mandates a "Diagnosis before Prescription" approach. It forces the agent to inspect the existing paint logic for specific anti-patterns before writing new code.

**Excerpt from .agent/skills/canvas\_optimization/SKILL.md:**

# **Canvas Optimization Skill**

## **Objective**

Identify performance bottlenecks in CustomPainter implementations and apply rendering optimizations to ensure 60fps performance during BLoC state updates.

## **Reasoning Protocol**

1. **Discovery**: Execute scripts/analyze\_painters.dart to list all CustomPainter subclasses.  
2. **Profiling (Static)**: For each painter, check:  
   * Does shouldRepaint return true unconditionally? (BAD)  
   * Does paint use saveLayer? (EXPENSIVE \- Verify necessity)  
   * Are complex calculations (Path parsing) done inside paint? (MOVE to BLoC or ViewModel)  
3. **Context Analysis**: Check the parent widget of the CustomPaint. Is it wrapped in a RepaintBoundary?  
4. **State Tracing**: Examine the BLoC state driving this painter. Does the state implement Equatable or freezed to support efficient equality checks?

## **Constraints**

* **NEVER** perform heavy computation (HTTP calls, JSON parsing, large list iteration) inside the paint method.  
* **ALWAYS** suggest RepaintBoundary for widgets that repaint frequently (animations/gestures) but are surrounded by static content.  
* **PREFER** drawPoints or drawVertices over iterating through a list to call drawCircle (Batching is faster).

### **4.2 Tooling: scripts/analyze\_painters.dart**

This Dart script uses the analyzer package to perform static analysis. It parses the Abstract Syntax Tree (AST) of the project to find specific coding patterns that correlate with poor performance. This is far more robust than regex matching, as it understands the semantic structure of the code.5

**Script Logic:**

1. **AST Traversal**: The script visits every ClassDeclaration.  
2. **Inheritance Check**: It identifies classes extending CustomPainter.  
3. **Method Inspection**:  
   * Inside shouldRepaint(oldDelegate): It looks for return true;.  
   * Inside paint(canvas, size): It counts occurrences of canvas.saveLayer.  
4. **Reporting**: It outputs a structured JSON or text report listing "High Risk" painters.

**Code Snippet (Concept):**

Dart

// scripts/analyze\_painters.dart (simplified)  
import 'package:analyzer/dart/analysis/utilities.dart';  
import 'package:analyzer/dart/ast/ast.dart';  
import 'package:analyzer/dart/ast/visitor.dart';

class PainterVisitor extends RecursiveAstVisitor\<void\> {  
  @override  
  void visitClassDeclaration(ClassDeclaration node) {  
    if (node.extendsClause?.superclass.name2.lexeme \== 'CustomPainter') {  
      print('Found Painter: ${node.name.lexeme}');  
      // Further analysis of methods...  
    }  
  }  
}  
//... implementation details...

The agent runs this script to gain immediate situational awareness: "I see BackgroundPainter and ForegroundPainter. ForegroundPainter uses saveLayer and lacks shouldRepaint. I will focus my optimization efforts there."

### **4.3 Resources: resources/efficient\_painter.dart**

This resource file provides the agent with a "perfect" implementation to mimic. It demonstrates the use of a ViewModel to decouple the BLoC state from the painter, enabling efficient shouldRepaint checks.

**Key concepts illustrated in the resource:**

* **Separate Data Class**: Passing a ShapeViewModel instead of raw BLoC state.  
* **Smart Repaint**: shouldRepaint checking oldDelegate.data\!= data.  
* **Layering**: Using canvas.drawAtlas for batch rendering sprites, which is significantly faster than individual draw calls.17

## ---

**5\. Skill Implementation: BLoC Integrity & Architecture**

The bloc\_integrity skill focuses on maintainability and testability. It prevents the entropy that naturally occurs in large projects where boundaries between layers begin to blur.

### **5.1 Manifest: SKILL.md**

This manifest enforces the rules of Clean Architecture. It is essentially a linting rule set for the agent's logic.

**Excerpt from .agent/skills/bloc\_integrity/SKILL.md:**

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

### **5.2 Tooling: scripts/audit\_imports.dart**

While the Dart analyzer is powerful, a simple import auditor is often sufficient to check for architectural violations. This script scans the imports of all files in lib/features/\*/presentation/bloc/ and flags illegal dependencies.

**Script Logic:**

1. **File Globbing**: Find all \*\_bloc.dart files.  
2. **Import Parsing**: Read the import directives.  
3. **Rule Validation**:  
   * If import 'package:flutter/material.dart' \-\> **FAIL** (BLoC is coupled to UI framework).  
   * If import 'package:my\_app/features/other\_feature/...' \-\> **FAIL** (Cross-feature coupling).7

The agent uses this script to self-correct. If it generates a BLoC that imports material.dart, it can run this script, see the failure, and rewrite the code to remove the dependency.

### **5.3 Resources: resources/clean\_bloc\_template.dart**

A template file demonstrating the Feature-First structure using the flutter\_bloc and freezed packages.

**Table 1: Comparison of BLoC Implementation Patterns**

| Feature | Naive Implementation (Anti-Pattern) | Clean Implementation (Resource Standard) |
| :---- | :---- | :---- |
| **State Definition** | Mutable class with public fields. | freezed union types (immutable, copyWith). |
| **Event Logic** | Huge if/else or switch in mapEventToState. | Separate on\<Event\> handlers. |
| **Dependencies** | Instantiates http.Client directly. | Injects UseCase interfaces via constructor. |
| **Side Effects** | Calls Navigator.push inside BLoC. | Emits NavigationState listened to by UI. |

This resource ensures the agent generates code that adheres to the "Clean Implementation" column.

## ---

**6\. Skill Implementation: Dependency Management**

In large Flutter applications, circular dependencies are the silent killer of productivity. They break hot reload, confuse the analyzer, and make module extraction impossible. The dependency\_management skill gives the agent the ability to visualize and police the graph of the application.

### **6.1 Manifest: SKILL.md**

**Excerpt from .agent/skills/dependency\_management/SKILL.md:**

# **Dependency Management Skill**

## **Objective**

Ensure the directed acyclic graph (DAG) of project dependencies remains acyclic and loosely coupled.

## **Protocol**

1. **Pre-Change Analysis**: Before introducing a new import, run scripts/graph\_deps.py to check if the target module already depends on the source module (indirectly).  
2. **Cycle Detection**: If a cycle is detected, halt generation and propose an "Interface Extraction" refactor.  
3. **Layer Enforcement**:  
   * Core cannot depend on Features.  
   * Feature A cannot depend on Feature B directly (Must use Core interfaces or Deep Link routing).

## **Strategies**

* **Inversion of Control**: If A needs B, but B needs A, define an interface in A that B implements.  
* **Barrel Files**: Avoid importing file.dart directly if a library.dart exists, but beware of importing the barrel file if it re-exports the world (tree shaking issues).

### **6.2 Tooling: scripts/graph\_deps.py**

We utilize Python for this skill because of its superior graph processing libraries (networkx). The script parses Dart imports and builds a directed graph of the codebase.6

**Script Logic:**

1. **Regex Parsing**: Scans .dart files to extract import 'package:...'.  
2. **Graph Construction**: Nodes are files/libraries; edges are imports.  
3. **Cycle Analysis**: Uses networkx.simple\_cycles(G) to find strongly connected components.  
4. **Impact Analysis**: Calculates the "In-Degree" of nodes. A node with high in-degree (imported by many) is "High Risk" for modification.

**Agent Usage:**

"I am planning to move UserEntity from features/auth to features/profile. I will run graph\_deps.py to see which files import UserEntity. The graph shows 45 dependents across 3 features. Moving this will break the build. I will instead move it to core/domain/entities."

### **6.3 Resources: resources/architecture\_layers.mermaid**

A Mermaid diagram defining the allowed flow of dependencies.

Code snippet

graph TD  
    UI\[Presentation Layer\] \--\> Domain  
    Data \--\> Domain  
    UI \-.-\> Data  
    FeatureA \--\> Core  
    FeatureB \--\> Core  
    FeatureA \--x FeatureB

The agent references this text-based diagram to "visualize" the allowed architecture.

## ---

**7\. Research-First Strategies for High-Impact Decisions**

Having skills is not enough; the agent must know *when* and *how* to apply them. We propose three strategies that shift the agent from a "Code Generator" to a "Research Assistant."

### **7.1 Strategy 1: The Pre-Flight Simulation Protocol**

**Concept**: The agent is forbidden from writing production code until it has executed a "Simulation."

**Workflow**:

1. **Trigger**: User requests a complex refactor (e.g., "Change the drawing engine to support layers").  
2. **Research Phase**: The agent invokes its analysis scripts.  
   * analyze\_painters.dart: "How many painters currently exist? Do they support transparency?"  
   * graph\_deps.py: "Will adding a Layering system introduce cycles between the Editor and the Renderer?"  
3. **Hypothesis**: The agent generates a "Simulation Report."  
   * "I found that CanvasPainter is currently monolithic. Splitting it will require updating 12 tests. The dependency graph permits this change."  
4. **Execution**: Only after generating this report does the agent proceed to code.

**Why this works**: It forces the agent to load the *actual* context of the project into its working memory, rather than hallucinating a simple "Hello World" scenario. It grounds the solution in reality.20

### **7.2 Strategy 2: The Architectural RFC (Request for Comments)**

**Concept**: For decisions affecting multiple files, the agent writes a Design Document (RFC) instead of code.

**Workflow**:

1. **Trigger**: "Implement Undo/Redo functionality."  
2. **Drafting**: The agent reads the BLoC Integrity skill and drafts a plan.  
   * "I propose a TemporalStack class in core. The CanvasBloc will delegate state history to this stack."  
   * "I will use the Command Pattern."  
3. **Review (Human-in-the-Loop)**: The agent pauses. The user reviews the textual plan.  
   * *User Feedback*: "Don't use the Command Pattern; our state is small enough to just store snapshots."  
4. **Revision**: The agent updates the plan.  
5. **Coding**: The agent generates code based on the *approved* plan.

**Why this works**: It catches architectural misunderstandings early. Correcting a text plan costs pennies; rewriting 50 files of code costs dollars and hours.22

### **7.3 Strategy 3: The "Red Team" Verification Loop**

**Concept**: Using a dual-persona approach (or a second agent pass) to critique the generated code before showing it to the user.

**Workflow**:

1. **Generator**: The agent writes the code for a new feature.  
2. **Red Team**: The agent switches context (or invokes a sub-agent) loaded with the SKILL.md constraints.  
   * "Does this code violate the shouldRepaint rule?"  
   * "Does this import material.dart in the BLoC?"  
3. **Correction**: If the Red Team finds violations, the code is regenerated.  
4. **Final Output**: The user sees only the verified, compliant code.

**Why this works**: It automates the "Code Review" process. It uses the explicitly defined skills as a rubric for self-evaluation.1

## ---

**8\. Human-in-the-Loop: The "Stop" Button**

Even with advanced skills, agents can hallucinate or pursue destructive paths. We must implement rigorous HITL controls.

### **8.1 The "Halt" Protocol**

The SKILL.md files should define specific triggers that force the agent to stop and ask for permission.

**Halt Conditions:**

* **Deletion Volume**: "If the plan involves deleting more than 3 files, HALT."  
* **Dependency Risk**: "If a new dependency must be added to pubspec.yaml, HALT."  
* **Complexity Spike**: "If the Cyclomatic Complexity of a generated method exceeds 15, HALT."

When a Halt Condition is triggered, the agent outputs a warning: "⚠️ **HALT TRIGGERED**: This action requires deleting user\_repository.dart. Please confirm by typing 'PROCEED'.".23

### **8.2 The Interactive Debug Session**

In the event of a test failure (detected by the agent running flutter test via a script), the agent should not blindly retry. It should enter "Debug Mode," presenting the error log to the human and asking for a hypothesis.

"The test canvas\_draws\_correctly failed with RenderFlex overflow. I suspect the Column is unbounded. Shall I wrap it in an Expanded or change the layout?"

This collaborative debugging leverages human intuition for visual issues (which the agent cannot see) while utilizing the agent's speed for syntax correction.21

## ---

**9\. Conclusion**

The transition to Agentic Engineering in Flutter development is not about replacing developers; it is about augmenting them with autonomous systems that respect the craft. By organizing agent capabilities into the .agent/skills/ structure, we transform vague prompt engineering into rigorous architectural management.

The specific skills of **Canvas Optimization**, **BLoC Integrity**, and **Dependency Management** address the most common failure modes in high-performance Flutter apps: jank, spaghetti code, and fragile builds. When combined with Research-First strategies—simulations, RFCs, and Red Teaming—we create a workflow where the agent acts as a diligent junior engineer: researching before coding, adhering to style guides, and seeking approval for high-impact changes.

This approach ensures that as the codebase scales to 15,000, 50,000, or 100,000 lines, the agent remains a potent asset, maintaining the velocity and quality of the project rather than eroding it.

## ---

**10\. Appendix: Reference Implementation of Skills**

### **10.1 scripts/analyze\_painters.dart (Full Source)**

Dart

//.agent/skills/canvas\_optimization/scripts/analyze\_painters.dart  
import 'dart:io';  
import 'package:analyzer/dart/analysis/utilities.dart';  
import 'package:analyzer/dart/ast/ast.dart';  
import 'package:analyzer/dart/ast/visitor.dart';  
import 'package:path/path.dart' as p;

/// A script to analyze CustomPainter performance characteristics.  
/// Usage: dart analyze*\_painters.dart \[directory\]*  
void main(List\<String\> args) {  
  final root \= args.isNotEmpty? args : 'lib';  
  final dir \= Directory(root);  
    
  if (\!dir.existsSync()) {  
    print('Error: Directory $root not found.');  
    exit(1);  
  }

  print('Analyzing CustomPainters in $root...');  
    
  final visitor \= PainterVisitor();  
    
  for (final entity in dir.listSync(recursive: true)) {  
    if (entity is File && entity.path.endsWith('.dart')) {  
      try {  
        final result \= parseString(content: entity.readAsStringSync());  
        visitor.currentFile \= entity.path;  
        result.unit.visitChildren(visitor);  
      } catch (e) {  
        // Skip parse errors  
      }  
    }  
  }  
    
  visitor.printReport();  
}

class PainterVisitor extends RecursiveAstVisitor\<void\> {  
  String currentFile \= '';  
  final List\<String\> riskyPainters \=;  
  final List\<String\> optimizedPainters \=;

  @override  
  void visitClassDeclaration(ClassDeclaration node) {  
    if (node.extendsClause?.superclass.name2.lexeme \== 'CustomPainter') {  
      \_analyzePainter(node);  
    }  
    super.visitClassDeclaration(node);  
  }

  void \_analyzePainter(ClassDeclaration node) {  
    bool hasShouldRepaint \= false;  
    bool usesSaveLayer \= false;

    for (final member in node.members) {  
      if (member is MethodDeclaration) {  
        if (member.name.lexeme \== 'shouldRepaint') {  
          hasShouldRepaint \= true;  
          // Check for "=\> true" or "return true"  
          final body \= member.body.toSource();  
          if (body.contains('return true') |

| body.contains('=\> true')) {  
            // This is risky unless explicitly intended  
            hasShouldRepaint \= false; // Treat as if not optimized  
          }  
        }  
        if (member.name.lexeme \== 'paint') {  
          if (member.body.toSource().contains('saveLayer')) {  
            usesSaveLayer \= true;  
          }  
        }  
      }  
    }

    final name \= node.name.lexeme;  
    if (\!hasShouldRepaint |

| usesSaveLayer) {  
      riskyPainters.add('$name in ${p.basename(currentFile)} '  
          '(shouldRepaint: $hasShouldRepaint, saveLayer: $usesSaveLayer)');  
    } else {  
      optimizedPainters.add(name);  
    }  
  }

  void printReport() {  
    print('\\n--- Analysis Report \---');  
    print('Optimized Painters: ${optimizedPainters.length}');  
    print('Risky Painters: ${riskyPainters.length}');  
      
    if (riskyPainters.isNotEmpty) {  
      print('\\n The following painters may cause performance issues:');  
      for (final p in riskyPainters) {  
        print(' \- $p');  
      }  
      print('\\nRecommendation: Implement granular \`shouldRepaint\` checks and avoid \`saveLayer\`.');  
    } else {  
      print('\\n All painters appear to have basic optimizations.');  
    }  
  }  
}

### **10.2 scripts/graph\_deps.py (Full Source)**

Python

\#.agent/skills/dependency\_management/scripts/graph\_deps.py  
import os  
import re  
import sys  
import networkx as nx

def get\_imports(file\_path):  
    """Parses a dart file and returns a list of package imports."""  
    imports \=  
    with open(file\_path, 'r', encoding='utf-8', errors='ignore') as f:  
        content \= f.read()  
        \# Matches: import 'package:my\_app/...'  
        matches \= re.findall(r"import\\s+\['\\"\]package:(\[^/\]+)/(\[^'\\"\]+)\['\\"\]", content)  
        for pkg, path in matches:  
            \# We assume the current package is named 'my\_app' (replace with actual name)  
            \# In a real script, parse pubspec.yaml to get the package name  
            if pkg \== 'my\_app':   
                imports.append(path)  
    return imports

def build\_graph(root\_dir):  
    """Walks the directory and builds a dependency graph."""  
    G \= nx.DiGraph()  
      
    for root, \_, files in os.walk(root\_dir):  
        for file in files:  
            if file.endswith(".dart"):  
                full\_path \= os.path.join(root, file)  
                \# Convert to relative path matching import structure  
                rel\_path \= os.path.relpath(full\_path, root\_dir).replace(os.sep, '/')  
                  
                G.add\_node(rel\_path)  
                  
                imports \= get\_imports(full\_path)  
                for imp in imports:  
                    G.add\_edge(rel\_path, imp)  
    return G

def analyze\_graph(G):  
    """Analyzes the graph for cycles and high-coupling."""  
    print(f"Total Files: {G.number\_of\_nodes()}")  
    print(f"Total Dependencies: {G.number\_of\_edges()}")  
      
    \# Cycle Detection  
    cycles \= list(nx.simple\_cycles(G))  
    if cycles:  
        print(f"\\n Found {len(cycles)} circular dependencies:")  
        for cycle in cycles:  
            print(f"  \- {' \-\> '.join(cycle)}")  
    else:  
        print("\\n No circular dependencies found.")  
          
    \# Coupling Analysis  
    print("\\nTop 5 Most Coupled Files (In-Degree):")  
    in\_degrees \= sorted(G.in\_degree, key=lambda x: x, reverse=True)\[:5\]  
    for node, degree in in\_degrees:  
        print(f"  \- {node}: {degree} importers")

if \_\_name\_\_ \== "\_\_main\_\_":  
    if len(sys.argv) \< 2:  
        print("Usage: python graph\_deps.py \<lib\_directory\>")  
        sys.exit(1)  
          
    root\_dir \= sys.argv  
    graph \= build\_graph(root\_dir)  
    analyze\_graph(graph)

#### **Works cited**

1. Demystifying evals for AI agents \- Anthropic, accessed February 11, 2026, [https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)  
2. Accelerating Software Development \- Harnessing Agentic AI \- Infosys, accessed February 11, 2026, [https://www.infosys.com/iki/techcompass/harnessing-agentic-ai.html](https://www.infosys.com/iki/techcompass/harnessing-agentic-ai.html)  
3. What are AI agents? Definition, examples, and types | Google Cloud, accessed February 11, 2026, [https://cloud.google.com/discover/what-are-ai-agents](https://cloud.google.com/discover/what-are-ai-agents)  
4. Agentic Coding: How I 10x'd My Development Workflow | by nicolas \- Medium, accessed February 11, 2026, [https://medium.com/@dataenthusiast.io/agentic-coding-how-i-10xd-my-development-workflow-e6f4fd65b7f0](https://medium.com/@dataenthusiast.io/agentic-coding-how-i-10xd-my-development-workflow-e6f4fd65b7f0)  
5. Customizing static analysis \- Dart, accessed February 11, 2026, [https://dart.dev/tools/analysis](https://dart.dev/tools/analysis)  
6. Building a Dependency Graph of Our Python Codebase | Our Success Stories, accessed February 11, 2026, [https://www.python.org/success-stories/building-a-dependency-graph-of-our-python-codebase/](https://www.python.org/success-stories/building-a-dependency-graph-of-our-python-codebase/)  
7. Is the BLoC Pattern Outdated for Flutter? My Experience with BLoC vs. Riverpod \- Reddit, accessed February 11, 2026, [https://www.reddit.com/r/FlutterDev/comments/1l276nv/is\_the\_bloc\_pattern\_outdated\_for\_flutter\_my/](https://www.reddit.com/r/FlutterDev/comments/1l276nv/is_the_bloc_pattern_outdated_for_flutter_my/)  
8. Building a Scalable Folder Structure in Flutter Using Clean ..., accessed February 11, 2026, [https://dev.to/alaminkarno/building-a-scalable-folder-structure-in-flutter-using-clean-architecture-bloccubit-530c](https://dev.to/alaminkarno/building-a-scalable-folder-structure-in-flutter-using-clean-architecture-bloccubit-530c)  
9. Flutter architectural overview, accessed February 11, 2026, [https://docs.flutter.dev/resources/architectural-overview](https://docs.flutter.dev/resources/architectural-overview)  
10. Improving Flutter App Performance With Repaint Boundary Techniques \- Vibe Studio, accessed February 11, 2026, [https://vibe-studio.ai/insights/improving-flutter-app-performance-with-repaint-boundary-techniques](https://vibe-studio.ai/insights/improving-flutter-app-performance-with-repaint-boundary-techniques)  
11. Flutter Improve CustomPainter animation performance \- Stack Overflow, accessed February 11, 2026, [https://stackoverflow.com/questions/62624726/flutter-improve-custompainter-animation-performance](https://stackoverflow.com/questions/62624726/flutter-improve-custompainter-animation-performance)  
12. CustomPainter in Flutter: The Most Underused Power Tool \- Mantra Ideas, accessed February 11, 2026, [https://mantraideas.com/flutter-custompainter-complete-guide/](https://mantraideas.com/flutter-custompainter-complete-guide/)  
13. Clean Code Architecture and BLoC in Flutter: A Comprehensive ..., accessed February 11, 2026, [https://dev.to/princetomarappdev/clean-code-architecture-and-bloc-in-flutter-a-comprehensive-guide-for-beginners-and-experts-33k8](https://dev.to/princetomarappdev/clean-code-architecture-and-bloc-in-flutter-a-comprehensive-guide-for-beginners-and-experts-33k8)  
14. Flutter State Management Anti-Patterns You Should Stop Using in 2025 \- Medium, accessed February 11, 2026, [https://medium.com/@kpuneethkumar450/flutter-state-management-anti-patterns-you-should-stop-using-in-2025-2ccc28518cda](https://medium.com/@kpuneethkumar450/flutter-state-management-anti-patterns-you-should-stop-using-in-2025-2ccc28518cda)  
15. Flutter bloc render optimization : r/FlutterDev \- Reddit, accessed February 11, 2026, [https://www.reddit.com/r/FlutterDev/comments/16l656o/flutter\_bloc\_render\_optimization/](https://www.reddit.com/r/FlutterDev/comments/16l656o/flutter_bloc_render_optimization/)  
16. Optimize Flutter UI Performance Tips | by Shaimaasalama \- Medium, accessed February 11, 2026, [https://medium.com/@shaimaa333salama/optimize-flutter-ui-performance-tips-b44d41290a56](https://medium.com/@shaimaa333salama/optimize-flutter-ui-performance-tips-b44d41290a56)  
17. High-Performance Canvas Rendering \- Plague Fox, accessed February 11, 2026, [https://plugfox.dev/high-performance-canvas-rendering/](https://plugfox.dev/high-performance-canvas-rendering/)  
18. tutorial \- python imports graph \- pydoit, accessed February 11, 2026, [https://pydoit.org/tutorial-1.html](https://pydoit.org/tutorial-1.html)  
19. Using a graph representation to analyze python dependencies | by Avidan Eran | Medium, accessed February 11, 2026, [https://medium.com/@avidaneran/using-a-graph-representation-to-analyze-python-dependencies-a57cd681fa09](https://medium.com/@avidaneran/using-a-graph-representation-to-analyze-python-dependencies-a57cd681fa09)  
20. What is AI Agent Planning? | IBM, accessed February 11, 2026, [https://www.ibm.com/think/topics/ai-agent-planning](https://www.ibm.com/think/topics/ai-agent-planning)  
21. 3 Techniques to Effectively Utilize AI Agents for Coding | Towards Data Science, accessed February 11, 2026, [https://towardsdatascience.com/3-techniques-to-effectively-utilize-ai-agents-for-coding/](https://towardsdatascience.com/3-techniques-to-effectively-utilize-ai-agents-for-coding/)  
22. From Prompting to Planning: The Rise of AI Agents \- Gravitee, accessed February 11, 2026, [https://www.gravitee.io/blog/from-prompting-to-planning-ai-agents](https://www.gravitee.io/blog/from-prompting-to-planning-ai-agents)  
23. My Processes for Better Agentic Coding \- How to structure prompts to manage your agent : r/vibecoding \- Reddit, accessed February 11, 2026, [https://www.reddit.com/r/vibecoding/comments/1mwdzlj/my\_processes\_for\_better\_agentic\_coding\_how\_to/](https://www.reddit.com/r/vibecoding/comments/1mwdzlj/my_processes_for_better_agentic_coding_how_to/)  
24. Effective Agentic Coding Practices \- Builder Society, accessed February 11, 2026, [https://www.buildersociety.com/threads/effective-agentic-coding-practices.7796/](https://www.buildersociety.com/threads/effective-agentic-coding-practices.7796/)