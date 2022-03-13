#include <fstream>
#include <iostream>
#include <tuple>
#include <cstdarg>

#include "bloom.h"

using namespace std;

struct bloom bloom;

long long parse_file(const std::string& filename, struct bloom * bloom) {
    std::ifstream input_file(filename);

    long long collisions = 0;

    if (!input_file.is_open()) {
        cerr << " [x] Unable to open file '" << filename << "'" << endl;
        return 0;
    }

    std::string line;
    while (getline(input_file, line)) {
        if (bloom_check(bloom, line.c_str(), line.length())) {
            collisions++;
        }

        bloom_add(bloom, line.c_str(), line.length());
    }

    input_file.close();

    return collisions;
}

void die(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    fprintf(stderr, "\n");
    exit(1);
}

int main(int argc, const char *argv[]) {
    if (argc < 4) {
        die("Usage: bloomgenerator <size of filter> <input file> <output file>");
    }

    int res = 0;

    res += bloom_init(&bloom, stoll(argv[1]), 0.00000001);

    if (res != 0) {
        die("Unable to initialize bloom filter");
    }

    parse_file(argv[2], &bloom);
    bloom_dump(&bloom, argv[3]);
    bloom_free(&bloom);

    return 0;
}