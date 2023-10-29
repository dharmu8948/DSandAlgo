// Reverse a String using Stack
#include <bits/stdc++.h>
using namespace std;
int main() {
    string str = "dharmendra";
    stack<char> st;
    for(int i=0;i<str.size();i++) {
       st.push(str[i]); 
    }
    string ans = "";
    while(!st.empty()) {
        char ch = st.top();
        ans.push_back(ch);
        st.pop();
    }
    cout<<"Reverse String is: "<<ans<<endl;
    return 0;
}