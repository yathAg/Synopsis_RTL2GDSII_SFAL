import os
import re
import shutil
import argparse

"""
This script renames and updates image references in a README file.
Given an input string, it searches for images in the README that match
specific formats (e.g., "Screenshot from YYYY-MM-DD HH-MM-SS.png" or "Screenshot YYYY-MM-DD HHMMSS.png"),
renames these images with the format <input_string>_<number>.png,
copies them to a specified "_docs" folder, and updates the image paths
in the README to reflect the new file locations. After copying, it
deletes the old image files.
"""

def rename_images_in_readme(input_string, readme_file="README.md", image_folder=".", docs_folder="_docs"):
    # Create the docs folder if it doesn't exist
    if not os.path.exists(docs_folder):
        os.makedirs(docs_folder)

    # Load README content with UTF-8 encoding
    with open(readme_file, 'r', encoding='utf-8') as file:
        content = file.read()

    # Define regex pattern for matching screenshot file names with timestamps
    pattern = r"Screenshot (?:from )?\d{4}-\d{2}-\d{2} (?:\d{2}-\d{2}-\d{2}|\d{6})\.png"

    # Find all matching image names
    matches = re.findall(pattern, content)

    # Process each matched file
    for index, match in enumerate(matches, start=1):
        new_filename = f"{input_string}_{index}.png"
        old_filepath = os.path.join(image_folder, match)
        new_filepath = os.path.join(docs_folder, new_filename)

        # Update the README content with the new path
        content = content.replace(match, os.path.join(docs_folder, new_filename))

        # Copy the image to the _docs folder with the new name
        if os.path.exists(old_filepath):
            shutil.copy(old_filepath, new_filepath)
            print(f"Copied {old_filepath} to {new_filepath}")
            # Delete the original file after copying
            os.remove(old_filepath)
            print(f"Deleted original image: {old_filepath}")
        else:
            print(f"Warning: {old_filepath} does not exist and was not copied.")

    # Write the updated content back to the README file with UTF-8 encoding
    with open(readme_file, 'w', encoding='utf-8') as file:
        file.write(content)
    print("README updated successfully.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Rename images in README and move them to _docs.")
    parser.add_argument("input_string", type=str, help="The string prefix to rename images with.")
    parser.add_argument("-s", action="store_true", help="Specify this flag to execute the renaming and copying.")

    args = parser.parse_args()

    if args.s:
        rename_images_in_readme(args.input_string)
    else:
        print("Please use the -s flag to execute the renaming and copying.")
