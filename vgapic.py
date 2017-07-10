from typing import Union
import struct

debug = True


class NONE:
    pass

def err(x):
    raise TypeError()

def intify(x : object) -> Union[int, None]:
    try:
        return int(x)
    except:
        return NONE()
    
def joins(x):
    for each_str in x:
        for each_chr in each_str:
            yield each_chr

def group(size : int):
    def _group(monoids, mappend):
        i = 1
        ret = next(monoids)
        try:
            for each_monoid in monoids:
                ret =  mappend(ret, each_monoid)
                i = i + 1
                if(i % size == 0):
                    yield ret
                    i = 1
                    ret = next(monoids)
        except:
            yield ret
    return _group


MAX_VALUE = 255
MIN_VALUE = 0

half_value = int((MAX_VALUE + MAX_VALUE) / 2)

input_file_path = input("Input path? Format: PPM \n").strip()
output_file_path = input("Output path \n").strip()

value_MAX = 1
value_MIN = 0


# input range
original_range = MAX_VALUE - MIN_VALUE
# output range
value_range = value_MAX - value_MIN

value_length = {
    1 : "c",
    2 : "h",
    4 : "i",
    8 : "q"
} [value_range]

value_type = {
    'c' : chr,
    'h' : err,
    'i' : int,
    'q' : err

} [value_length]

value_mapping = lambda x: int(x / original_range * value_range + 0.5)

input_file = open(input_file_path, 'r')
content = input_file.read().split()
content = filter(lambda x: (type(x) != NONE), map(intify, content))

next(content)
next(content)
next(content)

input_file.close()



if(not debug):
    value_binify = lambda x: bin(value_mapping(x))[2:]

    output_number = content

    output_bin = joins(map(value_binify, output_number))


    output_chrs = group(8)(output_bin, lambda x, y: x+y)

    output_bytes = map(lambda x: int(x, 2).to_bytes(1, 'big'), output_chrs)

    output_file = open(output_file_path, 'wb')

    for each_byte in output_bytes:
        output_file.write(each_byte)


    output_file.close()
else:
    
    output_file = open(output_file_path, 'w')
    output_file.write(" ".join(map(lambda x: str(value_mapping(x)), content)))
    output_file.close()


