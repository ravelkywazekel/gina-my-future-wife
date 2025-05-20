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

    // memasukkan node baru di awal daftar
    void insertAtBeginning(int value) {
        Node* newNode = new Node(value);
        newNode->next = head;
        head = newNode;
    }

    // memasukkan node baru pada posisi tertentu
    void insertAtPosition(int value, int position) {
        Node* newNode = new Node(value);
        if (position == 0) {
            newNode->next = head;
            head = newNode;
            return;
        }

        Node* temp = head;
        for (int i = 0; temp != nullptr && i < position - 1; i++) {
            temp = temp->next;
        }

        if (temp == nullptr) {
            std::cout << "Position out of bounds." << std::endl;
            delete newNode; // free memory jika posisi tidak valid
            return;
        }

        newNode->next = temp->next;
        temp->next = newNode;
    }

    // search nilai dalam list
    bool search(int value) {
        Node* temp = head;
        while (temp != nullptr) {
            if (temp->data == value) {
                return true;
            }
            temp = temp->next;
        }
        return false;
    }

    // menampilkan linked list
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

    list.insertAtBeginning(333);
    list.insertAtBeginning(666);
    list.insertAtBeginning(999);
    list.display(); // Output: 999, 666, 333, nullptr

    list.insertAtPosition(555, 2);
    list.display(); // Output: 999, 666, 555, 333, nullptr

    if (list.search(666)) {
        std::cout << "666 ditemukan dalam list" << std::endl; // output: 666 ditemukan dalam list
    } else {
        std::cout << "666 tidak ditemukan dalam list." << std::endl;
    }

    if (list.search(444)) {
        std::cout << "444 ditemukan dalam list" << std::endl;
    } else {
        std::cout << "444 tidak ditemukan dalam list" << std::endl; // output: 444 tidak ditemukan dalam list
    }

    return 0;
}
