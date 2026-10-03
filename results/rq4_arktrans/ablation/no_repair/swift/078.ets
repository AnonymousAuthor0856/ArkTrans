@Entry
@Component
struct Index {
  // Mock data to match the screenshot content
  private categories: string[] = ['Coding', 'Design', 'Business', 'Art'];
  private courses: string[] = ['Android Compose Mobile Dev', 'Photography Masterclass'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            // Header Section
            Row() {
              Column() {
                Text('Hello, Sophie')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1C1B1F')
                
                Text("Let's start learning!")
                  .fontSize(16)
                  .fontColor('#757575')
                  .margin({ top: 4 })
              }
              
              Blank()
              
              Row({ space: 8 }) {
                Button() {
                  Image($r('app.media.startIcon')) // Using allowed resource as placeholder for bell icon
                    .width(24)
                    .height(24)
                    .fillColor('#1C1B1F')
                }
                .backgroundColor(Color.Transparent)
                
                Stack() {
                  Circle()
                    .width(48)
                    .height(48)
                    .fill('#D0BCFF') // AppTheme.primary.opacity(0.2) approx
                    
                  Image($r('app.media.startIcon')) // Placeholder for face.smiling.fill
                    .width(24)
                    .height(24)
                    .fillColor('#6750A4')
                }
              }
            }
            .padding(24)
            
            // Search Bar
            Row() {
              Image($r('app.media.startIcon')) // Placeholder for magnifyingglass
                .width(20)
                .height(20)
                .fillColor('#757575')
              
              Blank().width(16)
              
              Text('Search for course...')
                .fontColor('#9E9E9E')
                .fontSize(16)
              
              Blank()
              
              Image($r('app.media.startIcon')) // Placeholder for slider.horizontal.3
                .width(20)
                .height(20)
                .fillColor('#6750A4')
            }
            .width('100%')
            .height(56)
            .padding({ left: 16, right: 16 })
            .backgroundColor(Color.White)
            .borderRadius(16)
            .margin({ left: 16, right: 16, bottom: 24 })
            
            // Ongoing Course Section
            Column() {
              Text('Ongoing Course')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
                .alignSelf(ItemAlign.Start)
              
              Stack() {
                Rect()
                  .width('100%')
                  .height(140)
                  .fill('#6750A4')
                  .borderRadius(24)
                
                Row() {
                  Column() {
                    Text('3D Modeling')
                      .fontSize(14)
                      .fontColor('#FFFFFF')
                      .opacity(0.7)
                    
                    Blank().height(8)
                    
                    Text('Blender Basic')
                      .fontSize(22)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FFFFFF')
                    
                    Blank().height(16)
                    
                    Row() {
                      Text('75%')
                        .fontSize(12)
                        .fontColor('#FFFFFF')
                      
                      Blank().width(8)
                      
                      Stack({ alignContent: Alignment.Start }) {
                        Rect()
                          .width('100%')
                          .height(6)
                          .fill('#FFFFFF')
                          .opacity(0.2)
                          .borderRadius(4)
                        
                        Rect()
                          .width('75%')
                          .height(6)
                          .fill('#FF9800') // Progress color
                          .borderRadius(4)
                      }
                    }
                  }
                  
                  Blank()
                  
                  Stack() {
                    Circle()
                      .width(60)
                      .height(60)
                      .fill(Color.White)
                    
                    Image($r('app.media.startIcon')) // Placeholder for play.fill
                      .width(32)
                      .height(32)
                      .fillColor('#6750A4')
                      .offset({ x: 2 })
                  }
                }
                .padding(20)
              }
            }
            .padding(24)
            
            // Categories Horizontal Scroll
            Scroll() {
              Row({ space: 12 }) {
                Blank().width(12)
                
                ForEach(this.categories, (category: string) => {
                  Text(category)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(category === 'Design' ? '#FFFFFF' : '#757575')
                    .backgroundColor(category === 'Design' ? '#FF6E40' : '#FFFFFF')
                    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                    .borderRadius(12)
                })
                
                Blank().width(12)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ left: 24, right: 24, bottom: 24 })
            
            // Recommended Section
            Column() {
              Row() {
                Text('Recommended')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1C1B1F')
                
                Blank()
                
                Text('See all')
                  .fontColor('#757575')
                  .fontSize(16)
              }
              
              Column() {
                ForEach(this.courses, (course: string) => {
                  Row() {
                    // Left Icon Area
                    Column() {
                       if (course.includes('Android')) {
                         Image($r('app.media.startIcon')) // Placeholder for checkmark
                           .width(40)
                           .height(40)
                           .fillColor('#1565C0')
                           .borderRadius(20)
                       } else {
                         Image($r('app.media.startIcon')) // Placeholder for star
                           .width(40)
                           .height(40)
                           .fillColor('#C2185B')
                       }
                    }
                    .width(100)
                    .justifyContent(FlexAlign.Center)
                    .backgroundColor(course.includes('Android') ? '#E3F2FD' : '#FCE4EC')
                    .borderRadius({ topLeft: 16, bottomLeft: 16 })
                    
                    // Right Content Area
                    Column() {
                      Text(course)
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#1C1B1F')
                        .maxLines(1)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                      
                      if (course.includes('Android')) {
                        Row() {
                          Image($r('app.media.startIcon')) // Star rating
                            .width(16)
                            .height(16)
                            .fillColor('#FFC107')
                            .margin({ right: 4 })
                          Text('4.9').fontColor('#757575').fontSize(14)
                        }.margin({ top: 4 })
                      }
                    }
                    .layoutWeight(1)
                    .padding({ left: 16, right: 16 })
                    
                    Image($r('app.media.startIcon')) // Heart
                      .width(24)
                      .height(24)
                      .fillColor('#E0E0E0')
                  }
                  .width('100%')
                  .height(100)
                  .backgroundColor(Color.White)
                  .borderRadius(16)
                  .margin({ bottom: 12 })
                })
              }
            }
            .padding(24)
            
            Blank().height(100) // Bottom padding for nav bar
          }
        }
        .scrollBar(BarState.Off)
      }
      
      // Bottom Navigation Bar
      Column() {
        Blank()
        
        Row() {
          Blank()
          
          Image($r('app.media.startIcon')) // Home
            .width(24)
            .height(24)
            .fillColor('#FFFFFF')
          
          Blank()
          
          Image($r('app.media.startIcon')) // Search
            .width(24)
            .height(24)
            .fillColor('#757575')
          
          Blank()
          
          Image($r('app.media.startIcon')) // Heart
            .width(24)
            .height(24)
            .fillColor('#757575')
          
          Blank()
          
          Image($r('app.media.startIcon')) // Person
            .width(24)
            .height(24)
            .fillColor('#757575')
          
          Blank()
        }
        .width('100%')
        .height(64)
        .padding({ left: 24, right: 24 })
        .backgroundColor('#1F1F1F')
        .borderRadius(32)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
        .margin({ bottom: 24 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}