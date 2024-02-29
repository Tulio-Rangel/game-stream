//
//  ContentView.swift
//  GamgeStream
//
//  Created by Tulio Rangel on 16/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //El navigation view es la vista para mandar a otra página con el navigationlink
        NavigationView {
            ZStack {
                //Spacer para evitar que cuando agreguemos algo, utilicemos el safe area
                Spacer()
                //Color de fondo
                Color(red: 0.02, green: 0.07, blue: 0.16, opacity: 1.0).ignoresSafeArea()
                
                VStack{
                    //Logo
                    Image("appLogo").resizable().aspectRatio( contentMode: .fit).frame(width: 186.2).padding(.bottom, 54.76)
                    
                    //Modulo con todo el inicio y registro
                    InicioYRegistroView()
                }
            }
        }
    }
}

//Modulo view que solo contiene el Iniciar y Registrar
struct InicioYRegistroView: View {
    
    @State var tipoInicioSesion = true
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {tipoInicioSesion = true}) {
                    Text("INICIA SESION").fontWeight(.bold).foregroundColor(tipoInicioSesion ? .white : .gray)
                }
                
                Spacer()
                
                Button(action: {tipoInicioSesion = false}) {
                    Text("REGÍSTRATE").fontWeight(.bold).foregroundColor(tipoInicioSesion ? .gray : .white)
                }
                
                Spacer()
            }
            
            Spacer(minLength: 42)
            
            if tipoInicioSesion == true {
                InicioSesionView()
            } else {
                RegistroView()
            }
        }
    }
}

//Modulo que contiene la vista de inicio de sesión
struct InicioSesionView : View {
    @State var correo = ""
    @State var contrasena = ""
    @State var isSecured: Bool = true
    @State var isPantallaHomeActive = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Correo electrónico").bold().foregroundColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                
                //Zstack que contiene el campo de entrada de correo
                ZStack(alignment: .leading) {
                    if correo.isEmpty {
                        //Uso el verbatim porque no tomaba el cambio de color
                        Text(verbatim: "ejemplo@gmail.com").font(.caption).foregroundColor(.gray)
                    }
                    TextField("", text: $correo).foregroundColor(.white)
                }
                Divider().frame(height: 1).background(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0)).padding(.bottom)
                
                Text("Contraseña").bold().foregroundColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                
                //Hstack que contiene un Zstack con el campo de entrada de la contraseña
                HStack() {
                    ZStack(alignment: .leading) {
                        Group {
                            if isSecured{
                                if contrasena.isEmpty {
                                    //Uso el verbatim porque no tomaba el cambio de color
                                    Text(verbatim: "Escribe tu contraseña").font(.caption).foregroundColor(.gray)
                                }
                                SecureField("", text: $contrasena).foregroundColor(.white)
                            } else {
                                TextField("", text: $contrasena).foregroundColor(.white)
                            }
                        }
                    }
                    //Botón para ver la contraseña
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                    }
                }
                Divider().frame(height: 1).background(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0)).padding(.bottom)
                
                //Opción de olvidaste contraseña
                Text("¿Olvidaste tu contraseña?").foregroundColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0)).font(.footnote).frame(width: 300, alignment: .trailing).padding(.bottom)
                
                //Botón para inicio de sesión, pero bien podría ser un módulo
                Button(action: {iniciarSesion()}, label: {
                    Text("INICIAR SESIÓN").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0), lineWidth: 2.0).shadow(color: .white, radius: 12.0))
                }).padding(.vertical, 40)
                
                //Sección para iniciar sesión con redes sociales
                Text("Inicia sesión con redes sociales").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .center).padding(.vertical, 20.0)
                
                //HStack que contiene los botones de redes sociales
                HStack {
                    Spacer()
                    Button(action: {iniciarSesionFacebook()}, label: {
                        Text("Facebook").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).background(RoundedRectangle(cornerRadius: 8.0).foregroundColor(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 1.0)))
                    })
                    Spacer()
                    Spacer()
                    Button(action: {iniciarSesionTwitter()}, label: {
                        Text("Twitter").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).background(RoundedRectangle(cornerRadius: 8.0).foregroundColor(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 1.0)))
                    })
                    Spacer()
                }
            }.padding(.horizontal, 80)
            
            //Navigation link para ir al home
            NavigationLink(
                destination: HomeView(),
                isActive: $isPantallaHomeActive,
                label: {
                    EmptyView()
                })
        }
    }
    
    func iniciarSesion() {
        isPantallaHomeActive = true
    }
}

//Modulo que contiene la vista de registro
struct RegistroView : View {
    @State var correo = ""
    @State var contrasena = ""
    @State var isSecured: Bool = true
    @State var isSecured2: Bool = true
    @State var confirmarContrasena = ""
    var body: some View {
        ScrollView {
            //Stack que contiene la selección de foto de perfil
            VStack(alignment: .center) {
                Text("Elige una foto de perfil").fontWeight(.bold).foregroundColor(.white)
                Text("Pedes cambiar o elegirla más adelante").font(.footnote).fontWeight(.light).foregroundColor(.gray).padding(.bottom)
                
                //Sección donde el usuario selecciona foto de perfil+
                Button(action: tomarFoto, label: {
                    ZStack {
                        Image("imagenPerfilEjemplo").resizable().aspectRatio(contentMode: .fit).frame(width: 85, height: 85)
                        Image(systemName: "camera").foregroundColor(.white)
                    }
                }).padding(.bottom)
            }
            
            //Stack con el formulario de registro
            VStack(alignment: .leading) {
                //Stack que solo contiene el formulario
                VStack(alignment: .leading) {
                    Text("Correo electrónico*").bold().foregroundColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                    
                    //Zstack que contiene el campo de entrada de correo
                    ZStack(alignment: .leading) {
                        if correo.isEmpty {
                            //Uso el verbatim porque no tomaba el cambio de color
                            Text(verbatim: "ejemplo@gmail.com").font(.caption).foregroundColor(.gray)
                        }
                        TextField("", text: $correo).foregroundColor(.white)
                    }
                    Divider().frame(height: 1).background(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0)).padding(.bottom)
                    
                    Text("Contraseña*").bold().foregroundColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                    
                    //Hstack que contiene un Zstack con el campo de entrada de la contraseña
                    HStack() {
                        ZStack(alignment: .leading) {
                            Group {
                                if isSecured{
                                    if contrasena.isEmpty {
                                        //Uso el verbatim porque no tomaba el cambio de color
                                        Text(verbatim: "Escribe tu contraseña").font(.caption).foregroundColor(.gray)
                                    }
                                    SecureField("", text: $contrasena).foregroundColor(.white)
                                } else {
                                    TextField("", text: $contrasena).foregroundColor(.white)
                                }
                            }
                        }
                        //Botón para ver la contraseña
                        Button(action: {
                            isSecured.toggle()
                        }) {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                        }
                    }
                    Divider().frame(height: 1).background(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0)).padding(.bottom)
                    
                    Text("Confirmar Contraseña*").bold().foregroundColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                    
                    //Hstack que contiene un Zstack con el campo de entrada de la contraseña
                    HStack() {
                        ZStack(alignment: .leading) {
                            Group {
                                if isSecured2{
                                    if confirmarContrasena.isEmpty {
                                        //Uso el verbatim porque no tomaba el cambio de color
                                        Text(verbatim: "Confirma tu contraseña").font(.caption).foregroundColor(.gray)
                                    }
                                    SecureField("", text: $confirmarContrasena).foregroundColor(.white)
                                } else {
                                    TextField("", text: $confirmarContrasena).foregroundColor(.white)
                                }
                            }
                        }
                        //Botón para ver la contraseña
                        Button(action: {
                            isSecured2.toggle()
                        }) {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0))
                        }
                    }
                    Divider().frame(height: 1).background(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0)).padding(.bottom)
                }
                
                //Sección con los botones
                //Botón para Registrarse, pero bien podría ser un módulo
                Button(action: {registrarse()}, label: {
                    Text("REGÍSTRATE").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color(red: 0.25, green: 0.79, blue: 0.63, opacity: 1.0), lineWidth: 2.0).shadow(color: .white, radius: 12.0))
                }).padding(.vertical, 20)
                
                //Sección para iniciar sesión con redes sociales
                Text("Regístrate con redes sociales").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .center).padding(.vertical, 5.0)
                
                //HStack que contiene los botones de redes sociales
                HStack {
                    Spacer()
                    Button(action: {registrarConFacebook()}, label: {
                        Text("Facebook").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).background(RoundedRectangle(cornerRadius: 8.0).foregroundColor(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 1.0)))
                    })
                    Spacer()
                    Spacer()
                    Button(action: {registrarConTwitter()}, label: {
                        Text("Twitter").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).background(RoundedRectangle(cornerRadius: 8.0).foregroundColor(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 1.0)))
                    })
                    Spacer()
                }
            }.padding(.horizontal, 40)
        }
    }
}

//Funciones de inicio de sesión


func iniciarSesionFacebook() {
    print("Se inició sesión con Facebook")
}

func iniciarSesionTwitter() {
    print("Se inició sesión con Twitter")
}

//Función para tomar foto de perfil
func tomarFoto() {
    print("Tomar foto de perfil")
}

//Funciones de registro
func registrarse() {
    print("Registrarse")
}

func registrarConFacebook() {
    print("Se registró con Facebook")
}

func registrarConTwitter() {
    print("Se registró con Twitter")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        Image("pantalla1").resizable().ignoresSafeArea()
        Image("pantalla2").resizable().ignoresSafeArea()
        
    }
}
