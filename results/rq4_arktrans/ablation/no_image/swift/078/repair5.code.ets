@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Bottom }) {
        // === AppTheme ===
        // Simulating AppTheme background with a full screen column
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#F5F5F5') // Assuming light theme background

        // === VStack ===
        Column({ space: 0 }) {
          // === ScrollView ===
          Scroll() {
            // === VStack ===
            Column({ space: 0 }) {
              // === HStack ===
              Row() {
                // === VStack ===
                Column({ space: 4 }) {
                  // === Text ===
                  Text('Hello, Sophie')
                    .fontColor('#000000') // AppTheme.onBackground approx
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                  
                  // === Text ===
                  Text("Let's start learning!")
                    .fontColor('#999999') // .gray approx
                    .fontSize(16)
                }
                
                // === Spacer ===
                Blank()
                
                // === HStack ===
                Row({ space: 8 }) {
                  // === Button ===
                  Button()
                    .type(ButtonType.Capsule)
                    .backgroundColor('#6750A4') // Primary color approx
                    .width(80)
                    .height(32)
                  
                  // === ZStack ===
                  Stack() {
                    // === Circle ===
                    Circle()
                      .width(48)
                      .height(48)
                      .fill(Color('#6750A4').opacity(0.2)) // AppTheme.primary.opacity(0.2)
                    
                    // === Image ===
                    // Using $r as per rules, though systemName implies SF Symbols which aren't native in ArkTS without assets
                    // We use the required resource name to satisfy compilation rules
                    Image($r('app.media.startIcon'))
                      .colorFilter(new ColorFilter().sourceColor(Color('#6750A4'))) // AppTheme.primary
                      .width(24)
                      .height(24)
                  }
                }
              }.padding(24)

              // === HStack (Search Bar) ===
              Row() {
                // === Image ===
                Image($r('app.media.startIcon')) // Placeholder for magnifyingglass
                  .colorFilter(new ColorFilter().sourceColor(Color('#999999'))) // .gray
                  .width(20)
                  .height(20)
                
                // === Spacer ===
                Blank().width(16)
                
                // === Text ===
                Text('Search for course...')
                  .fontColor('#CCCCCC') // UIColor.lightGray approx
                
                // === Spacer ===
                Blank()
                
                // === Image ===
                Image($r('app.media.startIcon')) // Placeholder for slider.horizontal.3
                  .colorFilter(new ColorFilter().sourceColor(Color('#6750A4'))) // AppTheme.primary
                  .width(20)
                  .height(20)
              }
              .padding({ left: 24, right: 24 })
              .borderRadius(16)
              .backgroundColor('#FFFFFF')
              .height(56)
              .padding({ left: 16, right: 16 })

              // === VStack (Ongoing Course) ===
              Column({ space: 16 }) {
                // === Text ===
                Text('Ongoing Course')
                  .fontColor('#000000') // AppTheme.onBackground
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                
                // === ZStack (Card) ===
                Stack() {
                  // === RoundedRectangle ===
                  Rect()
                    .borderRadius(24)
                    .fill('#6750A4') // AppTheme.primary
                    .height(140)
                    .width('100%')
                  
                  // === HStack ===
                  Row({ space: 16 }) {
                    // === VStack ===
                    Column() {
                      // === Text ===
                      Text('3D Modeling')
                        .fontColor('#FFFFFF').opacity(0.7)
                        .fontSize(14)
                      
                      // === Spacer ===
                      Blank().height(8)
                      
                      // === Text ===
                      Text('Blender Basic')
                        .fontColor('#FFFFFF')
                        .fontSize(22)
                        .fontWeight(FontWeight.Bold)
                      
                      // === Spacer ===
                      Blank().height(16)
                      
                      // === HStack ===
                      Row() {
                        // === Text ===
                        Text('75%')
                          .fontColor('#FFFFFF')
                          .fontSize(12)
                        
                        // === Spacer ===
                        Blank().width(8)
                        
                        // === ZStack (Progress Bar) ===
                        Stack({ alignContent: Alignment.Start }) {
                          // === RoundedRectangle (Track) ===
                          Rect()
                            .borderRadius(4)
                            .fill('#FFFFFF').opacity(0.2)
                            .height(6)
                            .width(100) // Fixed width for track since geometry.size.width is tricky in static stack without container
                        
                          // === RoundedRectangle (Fill) ===
                          Rect()
                            .borderRadius(4)
                            .fill('#EADDFF') // AppTheme.progressColor approx
                            .height(6)
                            .width(75) // 75% of 100
                        }
                      }
                    }
                    
                    // === Spacer ===
                    Blank()
                    
                    // === ZStack (Play Button) ===
                    Stack() {
                      // === Circle ===
                      Circle()
                        .width(60)
                        .height(60)
                        .fill('#FFFFFF')
                      
                      // === Image ===
                      Image($r('app.media.startIcon')) // Placeholder for play.fill
                        .offset({ x: 2, y: 0 })
                        .colorFilter(new ColorFilter().sourceColor(Color('#6750A4'))) // AppTheme.primary
                        .width(32)
                        .height(32)
                    }
                  }.padding(20)
                }
              }.padding(24)

              // === ScrollView (Horizontal Categories) ===
              Scroll() {
                // === HStack ===
                Row({ space: 12 }) {
                  // === Spacer ===
                  Blank().width(12)
                  
                  // === ForEach (Categories) ===
                  // Mocking data for compilation
                  ForEach(['Design', 'Development', 'Marketing'], (category: string) => {
                    Text(category)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#999999') // Default gray
                      .backgroundColor('#FFFFFF')
                      .borderRadius(12)
                      .padding({ top: 12, bottom: 12, left: 24, right: 24 })
                  })
                  
                  // === Spacer ===
                  Blank().width(12)
                }
              }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

              // === VStack (Recommended) ===
              Column({ space: 16 }) {
                // === HStack ===
                Row() {
                  // === Text ===
                  Text('Recommended')
                    .fontColor('#000000') // AppTheme.onBackground
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  
                  // === Spacer ===
                  Blank()
                  
                  // === Text ===
                  Text('See all')
                    .fontColor('#999999') // .gray
                }
                
                // === ForEach (Courses) ===
                // Mocking data for compilation
                ForEach([1, 2], (item: number) => {
                  // === CourseCard ===
                  // Simplified CourseCard implementation
                  Column() {
                    Rect()
                      .width('100%')
                      .height(150)
                      .borderRadius(16)
                      .backgroundColor('#E0E0E0')
                    Text('Course Title')
                      .margin({ top: 8 })
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                  }.margin({ top: 12 })
                })
              }.padding(24)

              // === Spacer ===
              Blank().height(100)
            }
          }.scrollBar(BarState.Off)
        }

        // === VStack (Bottom Nav) ===
        Column() {
          // === Spacer ===
          Blank()
          
          // === HStack ===
          Row() {
            // === Spacer ===
            Blank()
            
            // === Image ===
            Image($r('app.media.startIcon')) // house.fill
              .colorFilter(new ColorFilter().sourceColor(Color('#FFFFFF')))
              .width(24)
              .height(24)
            
            // === Spacer ===
            Blank()
            
            // === Image ===
            Image($r('app.media.startIcon')) // magnifyingglass
              .colorFilter(new ColorFilter().sourceColor(Color('#999999'))) // .gray
              .width(24)
              .height(24)
            
            // === Spacer ===
            Blank()
            
            // === Image ===
            Image($r('app.media.startIcon')) // heart.fill
              .colorFilter(new ColorFilter().sourceColor(Color('#999999'))) // .gray
              .width(24)
              .height(24)
            
            // === Spacer ===
            Blank()
            
            // === Image ===
            Image($r('app.media.startIcon')) // person.fill
              .colorFilter(new ColorFilter().sourceColor(Color('#999999'))) // .gray
              .width(24)
              .height(24)
            
            // === Spacer ===
            Blank()
          }
          .padding({ left: 24, right: 24 })
          .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 }) // Color.black.opacity(0.2)
          .borderRadius(32)
          .backgroundColor('#1F1F1F') // Color(red: 0.12, green: 0.12, blue: 0.12)
          .padding({ top: 16, bottom: 16 })
        }
      }
    }.width('100%').height('100%')
  }
}