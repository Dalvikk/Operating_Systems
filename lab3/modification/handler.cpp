#include <iostream>
#include <fstream>
#include <csignal>
#include <string>
#include <sys/types.h>
#include <unistd.h>

using namespace std;

string mode = "usr1";

void usr1(int signum) {
    mode = "usr1";
}

void usr2(int signum) {
    mode = "usr2";
}

void term(int signum) {
    mode = "term";
}

void write_pid(const string& filename) {
    ofstream file(filename);
    file << getpid();
    file.close();
}

int main() {
    write_pid(".pid");

    signal(SIGUSR1, usr1);
    signal(SIGUSR2, usr2);
    signal(SIGTERM, term);

    int num = 1;
    while (true) {
        if (mode == "usr1") {
            num += 2;
            cout << num << endl;
        } else if (mode == "usr2") {
            num *= 2;
            cout << num << endl;
        } else {
            cout << "All done" << endl;
            cout << num << endl;
            return 0;
        }
        sleep(1);
    }
    return 0;
}
