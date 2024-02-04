// WAP to find the Word Occurrences
#include <bits/stdc++.h>
using namespace std;
int main() {
   string word = "I am Java Developer I am proud of it.";
   map<string, int> ans;
   string str = "";
   for(int i=0;i<word.size();i++) {
       if(word[i] != ' ') {
           str += word[i];
       }else {
           ans[str]++;
           str = "";
       }
   }
   for(auto  m : ans) {
       cout<< m.first <<" : "<< m.second <<", ";
   } 

    return 0;
}