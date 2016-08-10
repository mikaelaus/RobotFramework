import csv
class csvLibrary(object):

    def read_csv_file(self, filename):
        '''This creates a keyword named "Read CSV File"

        This keyword takes one argument, which is a path to a .csv file. It
        returns a list of rows, with each row being a list of the data in 
        each column.
        '''
        data = []
        with open(filename, 'rb') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                data.append(row)
        return data

    def csv_file_length(self, filename):
        '''This creates a keyword named "CSV File Length"

        This keyword takes one argument, which is a path to a .csv file. It
        returns number of rows.
        '''
        row_count = len(open(filename).readlines())
        return row_count