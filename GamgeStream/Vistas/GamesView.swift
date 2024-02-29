//
//  GamesView.swift
//  GamgeStream
//
//  Created by Tulio Rangel on 21/12/22.
//

import SwiftUI
import Kingfisher

struct GamesView: View {
    
    @ObservedObject var todosLosVideojuegos = ViewModel()
    
    @State var gameviewIsActive: Bool = false
    @State var url:String = ""
    @State var titulo:String = ""
    @State var studio:String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion:String = ""
    @State var tags:[String] = [""]
    @State var imgsUrl: [String] = [""]
    
    let formaGrid = [
        
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        ZStack{
            
            Color("Marine").ignoresSafeArea()
            
            VStack{
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{
                    
                    LazyVGrid(columns: formaGrid, spacing: 4){
                        
                        ForEach(todosLosVideojuegos.gamesInfo,id: \.self){
                            juego in
                            NavigationLink(destination: GameView(url: juego.videosUrls.mobile, titulo: juego.title, studio: juego.studio, calificacion: juego.contentRaiting, anoPublicacion: juego.publicationYear, descripcion: juego.description, tags: juego.tags, imgsUrl: juego.galleryImages),
                                           label: {
                                KFImage(URL(string: juego.galleryImages[0]))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle.init(cornerRadius: 4))
                                    .padding(.bottom, 12)
                                
                            })
                            
                        }
                        
                    }
                }
            }.padding(.horizontal,6)
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                
                //Muestra la información del primer elemento del json
                print("Primer elemento del json: \(todosLosVideojuegos.gamesInfo[0])")
                print("Titulo del primer elemento del json: \(todosLosVideojuegos.gamesInfo[0].title)")
            })
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}

//Para evitar tener ése montón de variables, se podrían utilizar dentro de un struct así:
/*
struct GameViewObject {
    let url: String
    let title: String
    let studio: String
    let calification: String
    let pubYear: String
    let description: String
    let tags: [String]
    let imgUrls: [String]
    
    init(game: Game) {
        url = game.videosUrls.mobile
        title = game.title
        studio = game.studio
        calification = game.contentRaiting
        pubYear = game.publicationYear
        description = game.description
        tags = game.tags
        imgUrls = game.galleryImages
    }
}

@State var gameVO: GameViewObject? = nil

Button(action: {
    gameVO = GameViewObject(game: game)
    print("tapped game \(gameVO!.title)")
})
*/
// el body quedaría así:
/*
var body: some View {
        ZStack {
            Color("marine").ignoresSafeArea()
            VStack{
                Text("Juegos").font(.title2).fontWeight(.bold).foregroundColor(Color("cian")).padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                ScrollView{
                    LazyVGrid(columns: formaGrid, spacing: 8){
                        ForEach(todosLosVideoJuegos.gamesInfo, id: \.self){
                            juego in
                            Button(action: {
                                gameVO = GameViewObject(game: juego)
                                print("tapped game \(gameVO!.title)")
                            }, label: {
                                Text("\(juego.title)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                                
                            })
                            
                        }
                    }
                }
            }.padding(.horizontal, 6)
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                print("Primer elemento del json: \(todosLosVideoJuegos.gamesInfo[0])")
                print("Titulo del primer videojuego del json: \(todosLosVideoJuegos.gamesInfo[0].title)")
                
            })
        
    }
}
*/
