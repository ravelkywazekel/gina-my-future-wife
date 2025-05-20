#include <iostream>
 
class Node {
public:
    int data;
    Node* next;
 
    Node(int value) {
        data = value;
        next = nullptr;
    }
};
 
class LinkedList {
private:
    Node* head;
 
public:
    LinkedList() {
        head = nullptr;
    }
 
    // function untuk memasukkan node baru di akhir list
    void insert(int value) {
        Node* newNode = new Node(value);
        if (head == nullptr) {
            head = newNode;
            return;
        }
        Node* temp = head;
        while (temp->next != nullptr) {
            temp = temp->next;
        }
        temp->next = newNode;
    }
 
    // function untuk menghapus node berdasarkan nilai
    void deleteNode(int value) {
        if (head == nullptr) return;
 
        // jika node yang akan dihapus adalah head
        if (head->data == value) {
            Node* temp = head;
            head = head->next;
            delete temp;
            return;
        }
 
        Node* current = head;
        Node* previous = nullptr;
 
        while (current != nullptr && current->data != value) {
            previous = current;
            current = current->next;
        }
 
        // jika nilai tidak ditemukan
        if (current == nullptr) return;
 
        previous->next = current->next;
        delete current;
    }
 
    // function untuk menampilkan linked list
    void display() {
        Node* temp = head;
        while (temp != nullptr) {
            std::cout << temp->data << ", ";
            temp = temp->next;
        }
        std::cout << "nullptr" << std::endl;
    }
 
    // destructor untuk free memory
    ~LinkedList() {
        Node* current = head;
        Node* nextNode;
        while (current != nullptr) {
            nextNode = current->next;
            delete current;
            current = nextNode;
        }
    }
};
 
int main() {
    LinkedList list;
 
    list.insert(333);
    list.insert(666);
    list.insert(999);
    list.display(); // Output: 333, 666, 999, nullptr
 
    list.deleteNode(666);
    list.display(); // Output: 333, 999, nullptr
 
    return 0;
}
