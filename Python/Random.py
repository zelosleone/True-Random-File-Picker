import os
import requests
import datetime
import math
import logging
import platform
import subprocess
import time
from datetime import datetime, UTC

# Configure logging
log_directory = os.path.join(os.getenv('APPDATA') or '.', 'RandomFileSelector')
os.makedirs(log_directory, exist_ok=True)
log_file_path = os.path.join(log_directory, 'random_selectionlog.txt')
logging.basicConfig(filename=log_file_path, level=logging.INFO, format='%(asctime)s: %(message)s')

# Important sentence and symbol remain the same
important_sentence = (
    "αιη αιωι ηωιαη αη ιω ωη αιηουευωαι εαι υο ιαω ιωη "
    "οαυ αεη υωυω χαβραχ φλιεσ κηρφι νυρω φωχω βωχ :7 "
    "הכפף לי כל הדיימונים, למען ישמעו לי כל דיימון, בין "
    "בשמים או ברוח או בארץ או מתחת לארץ או ביבשה או במים, "
    "וכל קסם ונגע אשר מאת האלוהים."
)
important_symbol = """
=#:
 :##:
   :**:
 :-. :##:
=@@@-  :##:
 :=*     :**:
           :*#:
           .*#:
 =+=     .*#:
=@@@-  .*#:
 :=: .*#:
   .*#:
 .*#:
=#:
"""

def write_log(message):
    logging.info(message)

def get_random_org_numbers(num, min_val, max_val):
    url = f"https://www.random.org/integers/?num={num}&min={min_val}&max={max_val}&col=1&base=10&format=plain&rnd=new"
    try:
        start_time = time.time()
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        numbers = [int(n) for n in response.text.strip().split()]
        elapsed_time = time.time() - start_time
        write_log(f"Got {len(numbers)} random numbers from Random.org in {elapsed_time:.2f} seconds")
        return numbers
    except requests.RequestException as e:
        write_log(f"Error accessing Random.org: {e}")
        print("Failed to retrieve random numbers from Random.org.")
        exit(1)

def process_important_data(data):
    # Get one true random number for the entire process
    char_list = list(data)
    shift = get_random_org_numbers(1, 1, len(char_list))[0]
    # Perform a mystic shift based on the true random number
    return data[shift:] + data[:shift]

def recite_and_process_data(data, count):
    print(f"Performing {count} mystical recitations...")
    # Instead of making multiple calls, we'll use one true random number
    # to perform the mystical transformations
    processed_data = process_important_data(data)
    write_log(f"Processed mystical data with {count} spiritual iterations")
    return processed_data

def draw_triangle_and_calculate():
    # Get all needed random numbers in one batch
    numbers = get_random_org_numbers(3, 1, 100)
    side_a, side_b, side_c = numbers[0], numbers[1], numbers[2]

    # Validate triangle inequality
    if not (side_a + side_b > side_c and side_b + side_c > side_a and side_a + side_c > side_b):
        # If invalid, use the numbers to create a valid triangle
        side_c = min(side_c, side_a + side_b - 1)

    # Calculate area and angles
    s = (side_a + side_b + side_c) / 2
    try:
        area = math.sqrt(s * (s - side_a) * (s - side_b) * (s - side_c))
        angle_A = math.degrees(math.acos((side_b**2 + side_c**2 - side_a**2) / (2 * side_b * side_c)))
        angle_B = math.degrees(math.acos((side_a**2 + side_c**2 - side_b**2) / (2 * side_a * side_c)))
        angle_C = 180 - (angle_A + angle_B)
    except ValueError:
        area = 1
        angle_A = angle_B = angle_C = 60

    triangle_randomness = area + angle_A + angle_B + angle_C
    write_log(f"Triangle calculations complete with randomness value: {triangle_randomness:.2f}")
    return round(triangle_randomness) if triangle_randomness > 0 else 1

def select_random_file(files, triangle_randomness):
    if not files:
        write_log("No files available to select.")
        return None

    # Get one true random number for final selection
    random_index = get_random_org_numbers(1, 0, len(files) - 1)[0]
    
    # Apply mystical influences
    now = datetime.now(UTC)
    tidal_influence = round(now.timetuple().tm_yday / 365.25 * (len(files) - 1))
    em_influence = round(now.hour / 24 * (len(files) - 1))
    
    combined_index = (random_index + tidal_influence + em_influence + triangle_randomness) % len(files)
    
    write_log(f"File selection complete with combined mystical indices")
    return files[combined_index]

def get_most_frequent_file(files, run_count, triangle_randomness):
    if not files:
        return None
    
    # Instead of multiple runs, we'll use one true random selection
    selected_file = select_random_file(files, triangle_randomness)
    if selected_file is None:
        return None
        
    return {
        'File': selected_file,
        'Count': 1,
        'Percentage': 100.0
    }

def open_file(file_path):
    try:
        print(f"Attempting to open file: {file_path}")
        if platform.system() == 'Windows':
            os.startfile(file_path)
        elif platform.system() == 'Darwin':  # macOS
            subprocess.call(['open', file_path])
        else:  # Linux and other systems
            subprocess.call(['xdg-open', file_path])
    except Exception as e:
        write_log(f"Failed to open file {file_path}: {e}")
        print(f"Failed to open file {file_path}: {e}")

def main():
    print("Important Phase:")
    print(important_symbol)
    print("Important Sentence:")
    print(important_sentence)

    question = input("What's your question? ")

    print("Processing mystical elements...")
    important_sentence_processed = recite_and_process_data(important_sentence, 108)
    important_symbol_processed = recite_and_process_data(important_symbol, 108)

    write_log(f"Important Sentence (after processing): {important_sentence_processed}")
    write_log(f"Important Symbol (after processing): {important_symbol_processed}")

    print("Starting script...")
    
    try:
        files = []
        for root, _, filenames in os.walk('.'):
            for filename in filenames:
                if filename.endswith('.py') or filename == 'random_selectionlog.txt':
                    continue
                rel_path = os.path.relpath(os.path.join(root, filename))
                files.append(rel_path)
    except Exception as e:
        write_log(f"Error collecting files: {e}")
        files = []

    if not files:
        write_log("No files found.")
        print("No files found.")
        return

    print(f"Files found: {len(files)}")
    write_log(f"Total number of files found: {len(files)}")

    print("\nAvailable files:")
    for i, file in enumerate(files, 1):
        print(f"{i}. {file}")

    print("\nCalculating mystical triangle...")
    triangle_randomness = draw_triangle_and_calculate()

    print("Performing final selection ritual...")
    result = get_most_frequent_file(files, 1, triangle_randomness)
    if result is None:
        print("The mystical forces could not select a file.")
        return

    selected_file = result['File']
    print(f"\nThe mystical forces have selected: {os.path.basename(selected_file)}")
    write_log(f"Selected file: {selected_file}")

    open_file(selected_file)
    input("\nPress Enter to exit...")

if __name__ == "__main__":
    main()
