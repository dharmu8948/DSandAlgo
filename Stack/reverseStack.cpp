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
void reverseStack(stack<int> &s) {
    // base case
    if(s.empty()) {
        return;
    }
    // ek case solve 
    int temp = s.top();
    s.pop();
    // baki recursion sambhal lega
    reverseStack(s);
    // insert at bottom
    insertAtBottom(s, temp);
    
    
}
int main() {
    stack<int> s;
    s.push(10);
    s.push(20);
    s.push(30);
    s.push(40);
    s.push(50);
   
    reverseStack(s);
     cout<<"Printing elements"<<endl;
    while(!s.empty()) {
        cout<<s.top()<<" ";
        s.pop();
    }
    
    cout<<endl;
    return 0;
}