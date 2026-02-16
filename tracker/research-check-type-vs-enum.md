# Research: Check by Type vs Check by Enum

**Findings:**

### Benchmark Results (AOT / Release)
We benchmarked `is Type` checks against `node.type == Enum.value` checks using 1,000,000 items with 100 iterations.
-   **Type Check (`is ConnectorNode`)**: ~670ms
-   **Enum Check (Virtual Getter)**: ~1040ms (Slower)
-   **Enum Check (Final Field)**: ~660ms (Comparable)

### Analysis
1.  **Performance:**
    -   In AOT builds (Flutter Release), `is` checks are extremely optimized, often outperforming or matching property access.
    -   Implementing a `type` property via a virtual getter (common in abstract base classes) introduces dispatch overhead, making it significantly slower (~50%).
    -   Only a `final` field implementation matches `is` check performance, but adds memory overhead per instance.

2.  **Developer Experience (DX):**
    -   **Type Promotion:** `is Type` enables Dart's automatic type promotion (e.g., accessing methods on `ConnectorNode` inside the `if` block). Enum checks require manual casting (`(node as ConnectorNode)...`), which is verbose and error-prone.
    -   **Maintainability:** Using `is Type` requires no additional boilerplate. `Enum` approach requires maintaining a separate `NodeType` enum and ensuring every subclass implements it correctly.

### Recommendation
**Stick to `is Type` checks.**
-   **Performance:** Superior or duplicate to alternatives.
-   **Code Quality:** Cleaner code with automatic type promotion.
-   **Maintenance:** Zero overhead.

**Decision:**
- Do not introduce a `NodeType` enum.
- Continue using `is ConnectorNode` / `is ShapeNode`.

**Status:** Completed
**Resolved:** 2026-02-16
