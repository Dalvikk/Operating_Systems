#include <iostream>
#include <fstream>
#include <csignal>
#include <string>

using namespace std;

int read_pid(const string& filename) {
    int pid;
    ifstream file(filename);
    file >> pid;
    file.close();
    return pid;
}

int main() {
    string s;
    while (cin >> s) {
        if (s == "+") {
            kill(read_pid(".pid"), SIGUSR1);
        } else if (s == "*") {
            kill(read_pid(".pid"), SIGUSR2);
        } else if (s == "term") {
            kill(read_pid(".pid"), SIGTERM);
            return 0;
        }
    }
    return 0;
}
