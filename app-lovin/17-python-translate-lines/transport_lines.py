#!/usr/bin/env python3
import sys

def transport_text_file(file_path):
    result=""
    with open(file_path, 'r') as file:
        for line in file:            
            result=result+"\\\""+line[:-1]+"\\\","

    print(result[:-1])

if __name__ == "__main__":    
    if len(sys.argv) != 2:
        print("Usage: python transport_lines.py <input_file> ")
        sys.exit(1)

    file_path = sys.argv[1]


    transport_text_file(file_path)