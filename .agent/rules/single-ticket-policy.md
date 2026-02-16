---
trigger: manual
---

# Rule: Single Ticket Per Conversation

**Objective:** Enforce a strict "one ticket per conversation" policy to maintain context purity, prevent regression, and ensure accurate time/effort tracking.

**Trigger:**
1.  **Explicit Context Switch:** The user asks to "start," "switch to," or "look at" a different Ticket ID (e.g., "Actually, let's do Ticket #456 instead").
2.  **Implicit Drift:** The user begins discussing requirements or code modules unrelated to the currently active ticket.

---

### Phase 1: Context Detection
**Current State:**
* **Active Ticket:** [The ID of the ticket currently being worked on]

**Logic:**
* If the user's request aligns with the **Active Ticket**, proceed normally.
* If the user's request targets a **Different Ticket**, **STOP** immediately and initiate Phase 2.

---

### Phase 2: The Interruption & Confirmation Protocol
**Action:**
Pause execution and present the user with a "Context Switch Confirmation" prompt. Do not execute the new request until the current work is secured.

**Agent Output Template:**
> "I notice you want to switch context to **[New Ticket ID]**.
>
> We are currently working on **[Current Ticket ID]**. To prevent data loss and keep our issue tracker clean, we must wrap up the current work first.
>
> **Please confirm the following actions for [Current Ticket ID]:**
> 1.  [ ] **Git Commit:** Commit all current changes with a WIP (Work In Progress) or Final message?
> 2.  [ ] **Update Ticket:** Post a comment on [Current Ticket ID] summarizing current status.
> 3.  [ ] **Status Change:** Update ticket status (e.g., to `In Progress` or `Paused`).
>
> *Shall I execute these wrap-up steps before switching to [New Ticket ID]?*"

---

### Phase 3: Execution of the Switch
**Once the user confirms "Yes":**

1.  **Commit Code:**
    * `git add .`
    * `git commit -m "Pausing work on [Current ID] to switch context. [Brief status summary]"`
2.  **Update Issue Tracker:**
    * Append a comment to the current ticket in `tracker/[Current ID].md` (or external tool): *"Context switch: Pausing work to address [New ID]. Current state saved."*
    * Update status metadata if necessary.
3.  **Clear Context:**
    * Reset local variables regarding the active ticket.
    * **Set Active Ticket** to `[New Ticket ID]`.
4.  **Begin New Task:**
    * Load context for the new ticket (refer to `are-u-ready` workflow).

---

### Exception: "Quick Look"
If the user explicitly states they only need to *read* or *reference* another ticket without changing code (e.g., "Check how Ticket #102 handled this"), you may proceed without a full context switch, but **warn the user** that no code changes should be made for the referenced ticket in this session.