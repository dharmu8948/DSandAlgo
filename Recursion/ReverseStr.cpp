// Online C++ compiler to run C++ program online
#include <bits/stdc++.h>
using namespace std;

 string reverseStr(string &str, int i, int j) {
     if(i>=j) {
         return str;
     }
     swap(str[i], str[j]);
     
     return reverseStr(str, i+1, j-1);
 }
int main() {
    string str = "Hello Bro";
    int i=0, j=str.length()-1;
    string ans = reverseStr(str, i, j);
    cout<<"Reverse String is : "<<ans<<endl;
    return 0;
}