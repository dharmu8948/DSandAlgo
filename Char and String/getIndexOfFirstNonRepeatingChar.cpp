// Online C++ compiler to run C++ program online
#include <bits/stdc++.h>
using namespace std;
int main() {
    string str = "abbcdcdcaf";
    bool found = false;
    map<char, int> mp;
    for(auto ch : str) {
        mp[ch]++;
    }
    for(int i=0;i<str.size();i++) {
        if(mp[str[i]]== 1) {
            cout<<"found at index: "<<i<<endl;
            found = true;
            break;
        }
    }
    if(found == false) {
        cout<<"No elements Found"<<endl;
    }

    return 0;
}