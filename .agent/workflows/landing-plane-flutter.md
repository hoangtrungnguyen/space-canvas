---
description: Trigger When the user says "Let's land the plane" or "Land the plane". Clean up the current session, ensure all work is tracked, and prepare the context for the next session to prevent "agent dementia."
---

# Protocol: Landing the Plane

**Trigger:** When the user says "Let's land the plane" or "Land the plane".

**Objective:** Clean up the current session, ensure all work is tracked, and prepare the context for the next session to prevent "agent dementia."


### Phase 1: Housekeeping & Cleanup
1.  **Update Issue Tracker:**
    * Review all progress made in this session.
    * Update relevant issues (in Beads, Linear, GitHub Issues, etc.) with the current status.
    * **Sync carefully:** Ensure the issue tracker perfectly reflects the code state.
2.  **Git State Hygiene:**
    * Commit all changes with clear, descriptive messages.
    * **Clean up:** Delete old branches that are merged or no longer needed.
    * **Stashes:** Pop or drop any temporary stashes.
3.  **Artifact Removal:**
    * Scan for and delete any temporary debugging artifacts, console logs, or temporary files created during the session.
4.  **Documentation Sync:**
    * Update `README.md` or relevant documentation files if the code behavior or setup instructions have changed.

### Phase 2: Continuity (The Handoff)
1.  **Analyze Future Work:**
    * Look through the backlog or remaining tasks in the issue tracker.
    * Identify the highest priority task for the *next* session.
2.  **Generate Next Session Prompt:**
    * Draft a specific, context-rich prompt that the user can copy-paste to start the next session.
    * **Format:** `Recommended next session prompt: [Insert Prompt Here]`
    * *Content:* The prompt should summarize where we left off, what the immediate goal is (e.g., "Continue working on Issue Y-444: Map rendering is broken"), and any relevant context the next agent will need to know immediately.

### Phase 3: Archival & Tracking
1.  **Create/Update Issue Log:**
    * Navigate to (or create) the `tracker/` directory.
    * Create a new markdown file named after the Issue ID (e.g., `tracker/ISSUE-123.md`).
2.  **Generate Header Metadata:**
    * At the very top of the file, insert a YAML-style or clean Markdown header optimized for agent parsing. It must include:
        * **Short Description:** A concise, high-density summary of the issue and resolution status (optimized for LLM reading).
        * **Timestamp:** The current date and time.
        * **Affected Modules:** A list of specific folders or modules modified during this session.
3.  **Archive Context:**
    * Append the full details of the conversation, decisions made, and technical reasoning to the body of the file.

    *Template for Tracker File:*
    ```markdown
    ---
    issue: [Issue ID]
    status: [analyze,readyForDev,inProgress,blocked,testing,done]
    Description: [Concise, high-density summary of the issue context and status]
    ---

    **Timestamp:** [YYYY-MM-DD HH:MM:SS]
    **Affected Modules:**
      - [path/to/module1]
      - [path/to/module2]
    
    ---
    
    ## Session Details
    [Full conversation log, decision notes, and technical context]
    ```

---

**Final Output:**
Confirm completion of all phases and display the **Recommended Next Session Prompt**.%