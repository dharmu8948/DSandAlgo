// WAP to place first element of Stack at last position
#include <bits/stdc++.h>
using namespace std;
void insertAtBottom(stack<int> &s, int target) {
    if(s.empty()) {
        s.push(target);
        return;
    }
    int temp = s.top();
    s.pop();
    //Recirsive call
    insertAtBottom(s,target);
    // BT
    s.push(temp);
}
int main() {
    stack<int> s;
    s.push(10);
    s.push(20);
    s.push(30);
    s.push(40);
    s.push(50);
    int topElement = s.top();
    s.pop();
    insertAtBottom(s, topElement);
    cout<<"Printing elements"<<endl;
    while(!s.empty()) {
        cout<<s.top()<<" ";
        s.pop();
    }
    cout<<endl;
    return 0;
}