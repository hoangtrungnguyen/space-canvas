# Archive

This folder contains features and experiments that have been temporarily sidelined or replaced but might be useful for future reference or re-implementation.

## Contents

### 1. QuadTree Infinite Canvas (`quad_tree_page/`)
- **Original Path**: `lib/features/space/view/pages/quad_tree_page`
- **Description**: An experimental implementation of an infinite canvas using the Quadtree spatial partitioning algorithm to optimize rendering.
- **Key Files**:
    - `whiteboard_widget.dart`: The custom painter and viewport logic.
    - `whiteboard_state.dart`: Logic for handling object insertion and spatial queries.
    - `quad_tree_page.dart`: The entry point for the experiment.

### 2. QuadTree Domain Service (`domain/`)
- **Original Path**: `lib/domain/quad_tree_service.dart`
- **Description**: A generic service wrapper for the `quadtree_dart` package, intended to be used by the UI components for spatial management.

## Restoration Instructions

To restore these features into the main application:

1.  **Move Files**: Move the folders/files back to their original paths in the `lib` directory.
2.  **Restore Dependencies**: Uncomment or add `quadtree_dart` to your `pubspec.yaml` dependencies.
    ```yaml
    dependencies:
      quadtree_dart: ^1.1.1
    ```
3.  **Update Analyzer**: Remove the `"archive/**"` entry from the `exclude` list in `analysis_options.yaml`.
4.  **Run Pub Get**: Run `flutter pub get` to fetch the restored dependencies.
