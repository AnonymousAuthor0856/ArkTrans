@Entry
@Component
struct Index {
  // Define constants to replace SwiftUI dynamic values for compilability
  private readonly scale: number = 1.0;
  private readonly titleH: number = 40;
  private readonly padX: number = 20;
  private readonly leftW: number = 60;
  private readonly rightW: number = 60;

  build() {
    Stack() {
      Column({ space: 10 * this.scale }) {
        // Text: Video Player
        Text('Video Player')
          .padding({ top: 12, bottom: 12 })
          .height(this.titleH)
          .fontColor('#e2e8f0')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        // RoundedRectangle (Video Surface)
        Rect()
          .borderRadius(24 * this.scale)
          .fill('#334155')
          .padding({ right: 10 })
          .height(300)
          .overlay(
            Text('Video Surface')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#e2e8f0')
              .opacity(0.9)
          )

        // Text: Journey through the Skies
        Text('Journey through the Skies')
          .padding({ top: 10, bottom: 10 })
          .padding({ left: 20, right: 20 })
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontColor('#e0e8f0')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        // VStack (Progress Bar Container)
        Column() {
          // HStack (Progress Bar Visuals)
          Row({ space: 18 * this.scale }) {
            Blank()
            
            // Capsule (Left part)
            Rect()
              .borderRadius(16 * this.scale) // Approximate capsule radius
              .width(this.leftW)
              .height(32 * this.scale)
              .fill('#1E3A8A')
            
            // RoundedRectangle (Middle connector)
            Rect()
              .borderRadius(3 * this.scale)
              .width(6 * this.scale)
              .height(72 * this.scale)
              .fill('#1E3A8A')
            
            // ZStack (Right part with indicator)
            Stack({ alignContent: Alignment.End }) {
              // Capsule (Right background)
              Rect()
                .borderRadius(16 * this.scale)
                .width(this.rightW)
                .height(32 * this.scale)
                .fill('#475569')
              
              // Circle (Indicator)
              Circle()
                .offset({ x: -10 * this.scale, y: 0 })
                .width(12 * this.scale)
                .height(12 * this.scale)
                .fill('#1E3A8A')
            }
            
            Blank()
          }

          // HStack (Time labels)
          Row() {
            Text('1:35')
              .padding({ left: 10 })
              .fontColor('#a3aab5')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
            
            Blank()
            
            Text('4:00')
              .padding({ right: 10 })
              .fontColor('#a3aab5')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
        }
        .padding({ top: 8 * this.scale, bottom: 6 * this.scale })
        .padding({ left: this.padX, right: this.padX })

        // HStack (Play Button)
        Row({ space: 24 * this.scale }) {
          // ZStack (Play Icon Container)
          Stack() {
            Circle()
              .fill('#1E3A8A')
            
            // Using system image name as string resource path or placeholder
            // Rule 2 says ONLY $r('app.media.startIcon') exists. 
            // However, skeleton specifies "play.fill". 
            // To be safe and compilable without missing resources, we use a generic Image with empty src 
            // or the allowed resource if it matches conceptually. 
            // Given strict rule, I will use an empty string source which renders nothing but compiles, 
            // or try to map 'play.fill' to a standard icon if possible. 
            // Since I cannot guarantee 'play.fill' exists in media, I will use '' and rely on styling.
            Image('') 
              .width(40 * this.scale)
              .height(40 * this.scale)
              .fillColor('#ffffff')
          }
          .width(120 * this.scale)
          .height(120 * this.scale)
        }
        .padding({ top: 10 * this.scale, bottom: 10 })

        // Button (Fullscreen)
        Button() {
          Text('Fullscreen')
            .fontColor('#47434e')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width(220 * this.scale)
            .height(64 * this.scale)
            .borderRadius(12 * this.scale)
            .border({ width: 1, color: '#475569', radius: 12 * this.scale })
        }
        .height(30)
        .padding({ top: 12 * this.scale })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#1e293b') // VP.Colors.background approximation
    }
    .width('100%')
    .height('100%')
  }
}