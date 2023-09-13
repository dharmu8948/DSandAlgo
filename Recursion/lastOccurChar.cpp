// Online C++ compiler to run C++ program online
#include <bits/stdc++.h>
using namespace std;

int lastOccurCharLeftToRight(string s, char ch, int index, int res) {
    
    // base case
    if(index>=s.length())
      return res;
      // ek case solve karo
     if(s[index] == ch) {
         res = index;
     }
     // baki recursion sambhal lega
     return lastOccurCharLeftToRight(s, ch, index+1,res);
}
int lastOccurCharRightToLeft(string s, char ch, int index, int res) {
	 // base case
    if(index<0)
      return res;
      // ek case solve karo
     if(s[index] == ch) {
         return index;
     }
     // baki recursion sambhal lega
	 return lastOccurCharRightToLeft(s, ch, index-1,res);
}

int main() {
    string str = "abcddbfddsdh";
    char ch = 'd';
    int i=0;
    int res = -1;
	//if you want left to right call
    //int ans = lastOccurCharLeftToRight(str,ch, i, res);
	
	// if you want right to left call
	int index = str.length()-1;
	int ans = lastOccurCharRightToLeft(str,ch, index, res);
    cout<<ans<<endl;
    return 0;
}