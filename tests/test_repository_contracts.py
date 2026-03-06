import unittest
from pathlib import Path

from scripts.repository_contracts import (
    REPO_ROOT,
    extract_vertical_slice_scenes,
    run_all,
)


class RepositoryContractsTest(unittest.TestCase):
    def test_repository_contracts_are_valid(self) -> None:
        self.assertEqual(run_all(), [])

    def test_vertical_slice_scene_index_is_not_empty(self) -> None:
        scenes = extract_vertical_slice_scenes()
        self.assertIn("C1_VS_S01", scenes)
        self.assertIn("C1_VS_S11", scenes)
        self.assertGreaterEqual(len(scenes), 10)

    def test_expected_runtime_data_files_exist(self) -> None:
        expected_paths = [
            REPO_ROOT / "data" / "localization" / "ui.csv",
            REPO_ROOT / "data" / "localization" / "dialogue.csv",
            REPO_ROOT / "data" / "letters" / "letters_it.json",
        ]
        for path in expected_paths:
            self.assertTrue(path.exists(), msg=f"Missing file: {path}")


if __name__ == "__main__":
    unittest.main()
