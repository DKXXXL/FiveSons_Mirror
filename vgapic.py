from typing import Union


class NONE:
    pass

MAX_VALUE = 255
MIN_VALUE = 0

half_value = int((MAX_VALUE + MAX_VALUE) / 2)

input_file_path = input("Input path? Format: PPM")
output_file_path = input("Output path?")

value_MAX = 1
value_MIN = 0


# input range
original_range = MAX_VALUE - MIN_VALUE
# output range
value_range = value_MAX - value_MIN

value_mapping = lambda x: int(x / original_range * value_range)
# value mapping fbetween different range

input_file = open(input_file_path, 'r')
content = input_file.read().split(" ") # type : List [str]
input_file.close()

output_number = filter(lambda x: (type(x) != NONE), map(intify, content))
output_bin = map(value_mapping, output_number)




def intify(x : object) -> Union[int, None]:
    try:
        return int(x)
    except:
        return NONE()
    


