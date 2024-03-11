// Online C++ compiler to run C++ program online
#include <bits/stdc++.h>
using namespace std;
void reverseString(string&str) {
    int i=0, j = str.size()-1;
    while(i<j) {
        swap(str[i],str[j]);
        i++;j--;
    }
}
void reverseWord(string&word) {
    string s = "";
    string ans = "";
   for(int i=0;i<word.size();i++){
       if(word[i] == ' ') {
           reverseString(s);
           ans += s+' ';
           s = "";
       }else {
           s += word[i];
       }
   }
   reverseString(s);
   ans += s+' ';
   reverseString(ans);
   cout<<"After reversing the Word: "<<ans<<endl;
}
void getCountOfElement(string str, char ch) {
    int count = 0;
    for(int i=0;i<str.size();i++) {
        if(str[i]==ch) count++;
    }
    cout<<"Total count of given element:  "<<count<<endl;
}
void convertIntoOppositeCase(string str) {
    cout<<"Convert given characters of a string to opposite case: "<<str<<endl;
    for(int i=0;i<str.size();i++) {
        if(str[i]>='a' && str[i]<= 'z') {
            str[i] = str[i]-32;
        }else if(str[i] >= 'A' && str[i] <= 'Z') {
            str[i] = str[i] + 32;
        }
    }
    cout<<"Characters of given string into opposite case is: "<<str<<endl;
}
void countVowels(string&str) {
    int count = 0;
    for(int i=0;i<str.size();i++) {
        if(str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u') count++;
    }
    cout<<"Total occurance of Vowels: "<<count<<endl;
}
void countVowelsUsingRec(string&str, int index, int &count) {
    if(str.size()>=index) return;
    if(str[index] == 'a' || str[index] == 'e' || str[index] == 'i' || str[index] == 'o' || str[index] == 'u') count++;
    countVowelsUsingRec(str,index+1, count);
}
int main() {
    // reverse given String
    string str = "GeeksforGeeks";
    reverseString(str);
    cout<<"After Reversal of String is: "<<str<<endl;
    
    // Reverse words in a given string
    string word = "I Like Program Very Much";
    reverseWord(word);
    
    //Program to count occurrence of a given character in a string
    string S = "geeksforgeeks";
    char ch = 'e';
    getCountOfElement(S,ch);
    
    //Convert characters of a string to opposite case
    string str1 = "geeksForgEeks";
    convertIntoOppositeCase(str1);
    
    // Program to count vowels in a string (Iterative and Recursive)
    string str2 = "geeksforgeeks portal";
    countVowels(str2);
    // recursive approach
    int count = 0;
   // countVowelsUsingRec(str, 0, count);
    //cout<<"dwdwdwd:  "<<count<<endl;
    
    // Check if a number is Palindrome
   // string str3 = ""
    return 0;
}