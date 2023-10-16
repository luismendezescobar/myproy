def validate_text_file(file_path):
    lines = set()
    errors = []

    with open(file_path, 'r') as file:
        for line_number, line in enumerate(file, start=1):  #get this: 1 152media.info, 152M10, RESELLER
                                                            #          2 152media.info, 152M312, RESELLER           
            line = line.strip()     #get the line only: 152media.info, 152M10, RESELLER                        
            
            # Rule 1: Check for duplicated lines
            if line in lines: 
#if line='152media.info, 152M324, RESELLER' in lines={'152media.info, 152M10, RESELLER', '152media.info, 152M312, RESELLER'}
                errors.append(f'Duplicate line found at line {line_number}: {line}')
            else:
                lines.add(line)
                            
            # Rule 2: Check for correct comma and space placement
            words = line.split(', ')  #words=['152media.info', '152M324', 'RESELLER']            

            print((word for word in words[:-1]))
            if any(len(word.split()) > 1 for word in words[:-1]):
                errors.append(f'Invalid comma and space placement at line {line_number}: {line}')
            
    '''        
    if errors:
        for error in errors:
            print(error)
        print(f'{len(errors)} error(s) found in the file.')
    else:
        print('File is valid; no errors found.')
    '''
if __name__ == "__main__":
    file_path = "./app-ads.txt"  # Replace with the path to your text file
    validate_text_file(file_path)
