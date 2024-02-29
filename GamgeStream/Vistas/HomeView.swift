//
//  Home.swift
//  GamgeStream
//
//  Created by Tulio Rangel on 20/12/22.
//

import SwiftUI
//Libreria para el tema del vídeo
import AVKit

struct HomeView: View {
    //No salía el color del tabview, con esto le damos color
    init(){
        UITabBar.appearance().backgroundColor = UIColor(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 0.6))
        UITabBar.appearance().isTranslucent = true
        print("Iniciando las vistas de Home")
    }
    
    @State var tabSeleccionando: Int = 2
    
    var body: some View {
        TabView(selection: $tabSeleccionando) {
            Text("Pantalla Perfil").font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }.tag(0)
                .toolbarBackground(Color("Blue-Gray"), for: .tabBar)
            
            GamesView().font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Juegos")
                }.tag(1)
                .toolbarBackground(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 0.6), for: .tabBar)
            
            PantallaHome()
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }.tag(2)
                .toolbarBackground(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 0.6), for: .tabBar)
            
            Text("Pantall Favoritos").font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(3)
                .toolbarBackground(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 0.6), for: .tabBar)
            
        }.accentColor(.white)
    }
}

struct PantallaHome : View {
    @State var textoBusqueda = ""
    var body: some View {
        ZStack {
            //Color de fondo
            Color(red: 0.02, green: 0.07, blue: 0.16, opacity: 1.0).ignoresSafeArea()
            
            VStack {
                Image("appLogo").resizable().aspectRatio( contentMode: .fit).frame(width: 186.2).padding(.vertical, 11.0)
                
                HStack {
                    Button(action: busqueda, label: {
                        Image(systemName: "magnifyingglass").foregroundColor(textoBusqueda.isEmpty ? Color(.gray) : Color(.white))
                    })
                    
                    ZStack (alignment: .leading) {
                        if textoBusqueda.isEmpty {
                            Text("Buscar un vídeo").foregroundColor(.gray).bold()
                        }
                        TextField("", text: $textoBusqueda).foregroundColor(Color(.white))
                    }
                }.padding([.top, .leading, .bottom], 11).background(Color(red: 0.14, green: 0.22, blue: 0.36, opacity: 0.6)).clipShape(Capsule())
                
                ScrollView(showsIndicators: false){
                    SubModuloHome()
                }
                
            }.padding(.horizontal, 18)
            
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
    }
    
    func busqueda() {
        print("Está buscando \(textoBusqueda)")
    }
}

struct SubModuloHome : View {
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    
    @State var isPlayerActive = false
    
    let urlVideos:[String] = ["https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256671638/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256720061/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256814567/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256705156/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256801252/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256757119/movie480.mp4"]
    
    var body: some View {
        VStack {
            //Sección de los más populares
            Text("LOS MÁS POPULARES").font(.title3).foregroundColor(.white).bold().frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.top)
            
            //Imagen del video del juego
            ZStack {
                Button(action: {
                    url = urlVideos[0]
                    print("URL: \(url)")
                    isPlayerActive = true
                }, label: {
                    VStack(spacing: 0) {
                        Image("The Witcher 3").resizable().scaledToFill()
                        Text("The Witcher 3").frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            .background(Color("Blue-Gray")).bold()
                    }
                })
                
                Image(systemName: "play.circle.fill").resizable().foregroundColor(.white).frame(width: 42, height: 43)
                
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center).padding(.vertical)
            
            //Sección de categorías sugeridad para ti
            Text("CATEGORÍAS SUGERIDAS PARA TI").font(.title3).foregroundColor(.white).bold().frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.top)
            
            //Carrusel usando scroll view y poniéndolo horizontal
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(Color("Blue-Gray")).frame(width: 160, height: 90)
                            Image("FPS").resizable().scaledToFit().frame(width: 42, height: 42)
                        }
                    })
                    
                    Button(action: {}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(Color("Blue-Gray")).frame(width: 160, height: 90)
                            Image("RPG").resizable().scaledToFit().frame(width: 42, height: 42)
                        }
                    })
                    
                    Button(action: {}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(Color("Blue-Gray")).frame(width: 160, height: 90)
                            Image("OpenWorld").resizable().scaledToFit().frame(width: 42, height: 42)
                        }
                    })
                }
            }
            
            //Sección recomendado para ti
            Text("RECOMENDADO PARA TI").font(.title3).foregroundColor(.white).bold().frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.top)
            
            //Carrusel usando scroll view y poniéndolo horizontal
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        url = urlVideos[1]
                        print("URL: \(url)")
                        isPlayerActive = true
                    }, label: {
                        Image("Abzu").resizable().scaledToFit().frame(width: 227, height: 128)
                    })
                    
                    Button(action: {
                        url = urlVideos[2]
                        print("URL: \(url)")
                        isPlayerActive = true
                    }, label: {
                        Image("Crash Bandicoot").resizable().scaledToFit().frame(width: 227, height: 128)
                    })
                    
                    Button(action: {
                        url = urlVideos[3]
                        print("URL: \(url)")
                        isPlayerActive = true
                    }, label: {
                        Image("DEATH STRANDING").resizable().scaledToFit().frame(width: 227, height: 128)
                    })
                }
            }
            
            //Sección vídeos que podrían gustarte
            Text("VIDEOS QUE PODRIAN GUSTARTE").font(.title3).foregroundColor(.white).bold().frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    Button(action: {url = urlVideos[4]
                        isPlayerActive = true}, label: {
                            Image("Cuphead").resizable().scaledToFit().frame(width: 240, height: 135)
                        })
                    Button(action: {url = urlVideos[5]
                        isPlayerActive = true}, label: {
                            
                            Image("Hades").resizable().scaledToFit().frame(width: 240, height: 135)
                        })
                    Button(action: {url = urlVideos[6]
                        
                        isPlayerActive = true}, label: {
                            
                            Image("Grand Theft Auto V").resizable().scaledToFit().frame(width: 240, height: 135)
                        })
                }
            }
            
            // para agregar insets a scrollview y este más arriba (hay más opciones, por mientras un color)
            Color.clear.frame(width: 1, height: 8, alignment: .center)
        }
        
        NavigationLink(
            destination: VideoPlayer(player: AVPlayer(url: URL(string: url)!))
                .frame(width: 400, height: 300).onDisappear(perform: {
                    AVPlayer().pause()
                }),
            isActive: $isPlayerActive,
            label: {EmptyView()})
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
