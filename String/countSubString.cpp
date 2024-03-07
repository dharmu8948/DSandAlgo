#include <bits/stdc++.h>
using namespace std;
int countSubstr(string s1, string s2) {
    int ans = 0;
    for(int i=0;i<s1.size();i++) {
        string str;
        for(int j = i;j<s1.size();j++) {
            str += s1[j];
            if(s2.find(str) != string::npos) ans++;
        }
    }
    return ans;
}
int main() {
    string s1 = "aab";
    string s2 = "aaaab";
    int count = countSubstr(s1,s2);
    cout<<"Tota SubString found is : "<<count<<endl;
    return 0;
}

// check out for more details of Problem: https://www.geeksforgeeks.org/number-of-substrings-of-one-string-present-in-other/