#!/usr/bin/env python3

import sys
def validate_text_file(file_path, output_file_path,error_file_output):
    lines = set()
    errors = []    

    #rules 1 and 2
    with open(file_path, 'r') as file:
        for line_number, line in enumerate(file, start=1):  #get this: 1 152media.info, 152M10, RESELLER
                                                            #          2 152media.info, 152M312, RESELLER           
            line = line.strip()     #get the line only: 152media.info, 152M10, RESELLER                        

           # Ignore lines that start with # because is a comment
            if line.startswith("#"):
                continue

            
            # Rule 1: Check for duplicated lines
            if line in lines: 
#if line='152media.info, 152M324, RESELLER' in lines={'152media.info, 152M10, RESELLER', '152media.info, 152M312, RESELLER'}
                errors.append(f'Rule 1 Duplicate line found at line {line_number}: {line}')
            else:
                lines.add(line)
                            
            # Rule 2: Check for correct comma and space placement
            #this chain would throw an error because the kk is missing a comma:
            #152media.info kk, 152M324, RESELLER      --->error
            #152media.info,    kk, 152M324, RESELLER  --->valid
            #152media.info,    , 152M324, RESELLER    --->valid

                                      #line='152media.info, 152M324, RESELLER' 
            words = line.split(', ')  #words=['152media.info', '152M324', 'RESELLER']            
            #print(words)

            #print([word for word in words[:-1]])
            if any(len(word.split()) > 1 for word in words):
                errors.append(f'Rule 2 Invalid comma and space placement at line {line_number}: {line}')
    #Rule 3        
    lines = set()
    with open(file_path, 'r') as file:
        for line_number, line in enumerate(file, start=1):  #get this: 1 152media.info, 152M10, RESELLER
                                                            #          2 152media.info, 152M312, RESELLER           
            line = line.strip()     #get the line only: 152media.info, 152M10, RESELLER                        
            # Rule 3: Check for duplicated lines even if spacing differs        
            # Example if there is this line:
            #'152media.info,     152M10, RESELLER' ------> error because that line already exists even if the 
            #                                              one that is already there has not so much spaces
            # Ignore lines that start with #
            if line.startswith("#"):
                continue
             
            line_no_spaces = ''.join(line.split())  # Remove spaces by splitting and joining without spaces
            normalized_line = ' '.join(line_no_spaces.split(','))  # Normalize spacing        
            error=False
            for myline in lines:
                normalized_dest = ' '.join(myline.split(', '))  # Normalize spacing                
                if normalized_line == normalized_dest:
                    errors.append(f'Rule 3 Duplicate line found at line {line_number}: {line}')
                    error=True
                    break
                else:                    
                    error=False                    
            if not error:
                lines.add(line)
    #Rule 4            
    lines = set()
    with open(file_path, 'r') as file:
        for line_number, line in enumerate(file, start=1):  #get this: 1 152media.info, 152M10, RESELLER
                                                            #          2 152media.info, 152M312, RESELLER           
            line = line.strip()     #get the line only: 152media.info, 152M10, RESELLER                        
            # Rule 4: Check for the count of commas and words in a row, this rule check if there are more commas than words
            # example line='152media.info,,152M10,RESELLER'
            # Ignore lines that start with #
            if line.startswith("#"):
                continue
            comma_count = line.count(',')
            words = line.split(', ') 
            word_count = len(words)
            if comma_count >= word_count:
                errors.append(f'Rule 4 Error at line  {line_number}: Comma count ({comma_count}) is equal to or greater than word count ({word_count}): {line}')
                

            # Rule 5: Check for blank words
            # example: line='152media.info, ,  ,152M10,RESELLER'
            if any(not word.strip() for word in words):
                errors.append(f'Rule 5 Error at line : Contains one or more blank words: {line}')
                


    if errors:
        with open(output_file_path, 'w') as output_file:
            for error in errors:
                output_file.write(error + '\n')
        print(f'{len(errors)} error(s) found in the file. Errors saved to {output_file_path}')
        with open(error_file_output, "w") as result_file:
            result_file.write("1")  # Write '1' to the result file if errors are found
    else:
        print('File is valid; no errors found.')
        with open(error_file_output, "w") as result_file:
            result_file.write("0")  # Write '0' to the result file if no errors are found
    
if __name__ == "__main__":    
    if len(sys.argv) != 4:
        print("Usage: python validate_file.py <input_file> <output_file> <error-file>")
        sys.exit(1)

    file_path = sys.argv[1]
    output_file_path = sys.argv[2]
    error_file_output = sys.argv[3]

    validate_text_file(file_path, output_file_path,error_file_output)