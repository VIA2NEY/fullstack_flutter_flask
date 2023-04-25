from werkzeug.security import generate_password_hash, check_password_hash

# def generer () :
#     hashed_password = generate_password_hash('password', method='sha256')
#     # print(hashed_password)
#     return hashed_password

# # Vérifiez si le mot de passe en clair 'password' correspond au mot de passe haché
# is_valid_password = check_password_hash(generer(), 'password')
# print(is_valid_password)
print('hello')
print("ENtrer les val de a et b")
a = input('Entrer a')
b = input('Entrer b')
if a != b:
    print('True')
else :
    print('false')

# def testdif() :
#     print("ENtrer les val de a et b")
#     a = input('Entrer a')
#     b = input('Entrer b')
#     if a != b:
#         print('True')
#     else :
#         print('false')