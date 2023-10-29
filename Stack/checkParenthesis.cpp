// Delete middle element from Stack
#include <bits/stdc++.h>
using namespace std;
 bool isValid(string s) {
        stack<char> st;
        for(int i=0;i<s.size();i++) {
            if(s[i] == '(' || s[i] == '{' || s[i] == '[') {
                st.push(s[i]);
            }else {
                if(st.empty()) {
                    return false;
                }
                else if((s[i] == ')' && st.top()=='(') || (s[i] == '}' && st.top()=='{') || 
                        (s[i] == ']' && st.top()=='[')) {
                         st.pop();
                  }else {
                      return false;
                  }
            }
        }
        return st.empty()==true;
    }
int main() {
   string s = "(){}[]";
   bool isValidParenthesis = isValid(s);
   if(isValidParenthesis) {
       cout<<"Valid Parenthesis"<<endl;
   }else {
       cout<<"Invalid Parenthesis"<<endl;
   }
   //printing
   
}