#include <unistd.h>

char Message[] = "This account is currently not available.\n";

int main()
{
    write(1, Message, sizeof(Message) - 1);
    return 1;
}
