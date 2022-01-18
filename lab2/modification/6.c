#include <stdio.h>
#include <proc/readproc.h>

int main() {
    int max_pid=-1;
    unsigned long max_mem=0;

    PROCTAB *ptp = openproc(PROC_FILLSTATUS | PROC_FILLSTAT);
    proc_t *pp;
    while (pp = readproc(ptp, NULL)) {
        int current_pid = pp->tid;
        unsigned long current_vm_rss = pp->vm_rss;

        if (current_vm_rss > max_mem) {
            max_mem = current_vm_rss;
            max_pid = current_pid;
        }
    }

    printf("pid = %d, mem = %lu", max_pid, max_mem);
    closeproc(ptp);
    return 0;
}
