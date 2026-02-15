# **Multiplayer Sync Strategy for Flutter Canvas**

Based on Figma's architecture, the goal is to make the data structure doing the heavy lifting for synchronization. By treating the document as a "Scene Graph" of "Atomic Properties," you avoid complex merge conflicts.

## **1\. Data Structure Strategy: "Atomic Property Granularity"**

### **The Problem**

If you sync the whole Rectangle object every time it changes, two users editing different parts of the same rectangle (e.g., User A changes color, User B changes position) will overwrite each other.

### **The Solution (Implemented in `lib/data/models/`)**

We wrapped every field in a `SyncableProperty<T>`.

* **Concept:** Instead of sending "Here is the new Rectangle", the app sends "Property 'fillColor' of Node 'ID-123' changed to 'Red' at time T".  
* **Benefit:** Allows concurrent editing of different properties on the same node without conflict.

## **2\. Ordering Strategy: "Fractional Indexing"**

### **The Problem**

If you store children as a simple Array/List [A, B, C]:

* User A moves C to index 1: [A, C, B]  
* User B moves C to index 0: [C, A, B]  
* Syncing these index integers (0, 1, 2) causes massive conflicts (who is really at index 1?).

### **The Solution**

Use **Fractional Indexing** (stored in `sortOrder`).

* Give every item a string key between 0 and 1.  
* Item A: "0.2"  
* Item B: "0.4"  
* To insert Item C between A and B, generate a key mathematically between them: "0.3".  
* **Result:** No indices to shift. User A and User B can insert items into the list without affecting the specific "index" number of other items.  
* **Algorithm:** We use string-based keys (lexicographical sorting).

## **3\. Conflict Resolution Strategy: "Last Write Wins" (LWW)**

### **The Logic**

For a visual canvas, complex merging (like in text editors/Git) is often unnecessary. If two users change the *exact same property* (e.g., Fill Color) at the same time, the one that arrived last (or has the higher timestamp) wins.

### **Implementation Guide**

1. **Timestamping:** Use a hybrid logical clock (HLC) or simple server timestamp.  
2. **Comparison:** 
   ```dart  
   // Inside the SyncableProperty.update method  
   if (incomingMessage.timestamp > currentProperty.timestamp) {  
     currentProperty.value = incomingMessage.value;  
     currentProperty.timestamp = incomingMessage.timestamp;
     currentProperty.lastAuthorId = incomingMessage.authorId;
     redrawCanvas();  
   }
   ```