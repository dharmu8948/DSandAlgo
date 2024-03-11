// Online C++ compiler to run C++ program online
#include <bits/stdc++.h>
using namespace std;
//Remove duplicates from a given string
void removeDuplicates(string&str) {
    if(str.size()==0) {
        cout<<"Given String is Empty"<<endl<<endl;
        return ;
    }
    cout<<"Before Removing Duplicates string is::"<<endl<<endl;
    int arr[26] = {0};
    string ans = "";
    
    for(int i=0;i<str.size();i++) {
        if(arr[str[i]-'a'] != -1) {
           // cout<<"Hi"<<endl;
            ans += str[i];
            arr[str[i]-'a'] = -1;
        }
    }
    cout<<"After Removing Duplicates string is::"<<endl<<endl;
}

//Check if a string is substring of another --> Approach 1
void checkSubString(string& str1, string& str2) {
    if(str1.size() > str2.size()) {
        cout<<"str1 cannot be greater than str2"<<endl;
        return;
    }
    string temp = "";
    for(int i = 0;i<str1.size();i++) {
        temp += str2[i];
    }
    int count = 0;
    for(int i=str1.size();i<str2.size();i++) {
        count++;
        temp.erase(0,1);
        temp.push_back(str2[i]);
        if(temp == str1){
            cout<<"string found at index:: "<<count<<endl;
            return ;
        }
    }
    cout<<"First String is not found so index is:: -1"<<endl;
    return ;
}
//Check if a string is substring of another --> Approach 2
void checkSubString2(string& str1, string& str2)  {
    if (str2.find(str1) != string::npos) {
        cout<<"Substring is found at index:: "<< str2.find(str1)<<endl<<endl;
        return;
    }else {
        cout<<"Substring not found so index is:: -1"<<endl<<endl;
        return ;
    }
}
//Remove minimum number of characters so that two strings become anagram
int makeAnagram(string str1, string str2) {
    // make hash array for both string and calculate 
    // frequency of each character 
    int count1[26] = {0}, count2[26] = {0}; 
  
    // count frequency of each character in first string 
    for (int i=0; str1[i]!='\0'; i++) 
        count1[str1[i]-'a']++; 
  
    // count frequency of each character in second string 
    for (int i=0; str2[i]!='\0'; i++) 
        count2[str2[i]-'a']++; 
  
    // traverse count arrays to find number of characters 
    // to be removed 
    int result = 0; 
    for (int i=0; i<26; i++) 
        result += abs(count1[i] - count2[i]); 
    return result;
}
int numberOfManupulationToMakeAnagram(string& s1, string& s2) {
    int count = 0; 
    // store the count of character 
    int char_count[26]; 
    for(int i = 0; i < 26; i++){
        char_count[i] = 0;
    }
    // iterate though the first String 
    // and update count 
    for(int i = 0; i < s1.length(); i++) 
       char_count[s1[i] - 'a']++; 
 
    // iterate through the second string 
    // update char_count. 
    // if character is not found in 
    // char_count then increase count 
    for(int i = 0; i < s2.length(); i++){ 
        char_count[s2[i] - 'a']--;       
    }
       
    for(int i = 0; i < 26; ++i){
      if(char_count[i] != 0){
        count+=abs(char_count[i]);
      }
    }
        return count / 2; 
}
//Capitalize the first and last character of each word in a string 
void makeCapitalFirstAndLast(string&str) {
    if(str.size() == 0) {
        cout<<"String is Empty"<<endl<<endl;
        return ;
    }
    string ans = "";
    ans += toupper(str[0]);
    for(int i=1;i<str.size();i++) {
        if(str[i] != ' ' && str[i-1] == ' ') {
            ans.push_back(toupper(str[i]));
        }
        else if(str[i] == ' ') {
            ans[i-1] = toupper(str[i-1]);
            ans.push_back(' ');
        }else {
            ans.push_back(str[i]);
        }
    }
    ans[ans.size()-1] = toupper(str[ans.size()-1]);
    cout<<"After Capitalize the first and last character of each word in a string:: "<<ans<<endl<<endl;
}
//Check if given strings are rotations of each other or not
bool areRotations(string &str1, string &str2)
{
    /* Check if sizes of two strings are same */
    if (str1.length() != str2.length())
        return false;
 
    string temp = str1 + str1;
    return (temp.find(str2) != string::npos);
}
int main() {
    //Remove duplicates from a given string
    string str = "geeksforgeeks";
    //out put should be ->  geksfor
    removeDuplicates(str);
    
    //Check if a string is substring of another
    string str1 = "for";
    string str2 = "geeksforgeeks";
    //checkSubString(str1, str2); // Approach 1
    checkSubString2(str1, str2); // Approach 2
    
    //Remove minimum number of characters so that two strings become anagram
    string str3 = "bcadeh";
    string str4 = "hea";
    int ans = makeAnagram(str3, str4);
    cout<<"Minimum removal to make string as Anagram is :: "<<ans<<endl<<endl;
    
    //Minimum Number of Manipulations required to make two Strings Anagram Without Deletion of Character
    string str5 = "ddcf";
    string str6 = "cedk";
    sort(str6.begin(), str6.end());
    sort(str5.begin(), str5.end());
    int minDeletion = numberOfManupulationToMakeAnagram(str5, str6);
    cout<<"Minimum deletion required is :: "<<minDeletion<<endl<<endl;
    
    //Capitalize the first and last character of each word in a string
    string str7 = "Geeks for geeks";
    // output -> GeekS FoR GeekS
    makeCapitalFirstAndLast(str7);
    
    //Check if given strings are rotations of each other or not
    string str8 = "ABCD";
    string str9 = "CDAB";
    //output -> true
    bool isRotation = areRotations(str8, str9);
    cout<<"Given strings are roatation of each other or not:: "<<isRotation<<endl<<endl;

    return 0;
}