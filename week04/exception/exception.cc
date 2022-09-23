/ compile with:
//   g++ -g -std=c++11 exception.cc -o exception -pthread
#include <thread>
#include <vector>
#include <iostream>

void foo() {
    std::vector<int> v;
    std::cout << v.at(100) << std::endl;
}

int main() {
    std::thread t(foo);
    t.join();
}

