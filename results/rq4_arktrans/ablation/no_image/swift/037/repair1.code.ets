import { LinearGradient, ColorStop } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  // Mock data interfaces to satisfy type requirements
  interface BudgetItem {
    name: string
    value: number
    gradient: LinearGradient
  }

  interface PieSliceData {
    start: number
    end: number
    gradient: LinearGradient
  }

  @State slices: PieSliceData[] = [
    { 
      start: 0, 
      end: 120, 
      gradient: new LinearGradient({ 
        angle: 90, 
        stops: [
          { offset: 0, color: '#FF6B6B' },
          { offset: 1, color: '#FF8E8E' }
        ] 
      }) 
    },
    { 
      start: 120, 
      end: 240, 
      gradient: new LinearGradient({ 
        angle: 90, 
        stops: [
          { offset: 0, color: '#4ECDC4' },
          { offset: 1, color: '#75DAD3' }
        ] 
      }) 
    },
    { 
      start: 240, 
      end: 360, 
      gradient: new LinearGradient({ 
        angle: 90, 
        stops: [
          { offset: 0, color: '#FFE66D' },
          { offset: 1, color: '#FFF09F' }
        ] 
      }) 
    }
  ]

  @State budgetData: BudgetItem[] = [
    { 
      name: 'Food', 
      value: 500, 
      gradient: new LinearGradient({ 
        angle: 90, 
        stops: [
          { offset: 0, color: '#FF6B6B' },
          { offset: 1, color: '#FF8E8E' }
        ] 
      }) 
    },
    { 
      name: 'Transport', 
      value: 200, 
      gradient: new LinearGradient({ 
        angle: 90, 
        stops: [
          { offset: 0, color: '#4ECDC4' },
          { offset: 1, color: '#75DAD3' }
        ] 
      }) 
    },
    { 
      name: 'Utilities', 
      value: 300, 
      gradient: new LinearGradient({ 
        angle: 90, 
        stops: [
          { offset: 0, color: '#FFE66D' },
          { offset: 1, color: '#FFF09F' }
        ] 
      }) 
    }
  ]

  @State totalValue: number = 1000

  build() {
    Stack() {
      // === ZStack (Main Content) ===
      Stack() {
        // === VStack (Scrollable Content) ===
        Column() {
          // === HStack (Header) ===
          Row() {
            Blank()
            Text('Monthly Budget')
              .padding({ top: 8, bottom: 8 })
              .fontColor('#4A5568')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            Blank()
          }.width('100%')

          // === ScrollView ===
          Scroll() {
            // === VStack (Content Container) ===
            Column() {
              // === ZStack (Chart Area) ===
              Stack() {
                // === ForEach (Pie Slices) ===
                ForEach(this.slices, (slice: PieSliceData) => {
                  // Simulating PieSlice with Arc for ArkTS compatibility as PieSlice is not standard
                  // Using a simple Circle or Arc representation. 
                  // Since specific custom components like PieSlice aren't in standard ArkTS, 
                  // we use a placeholder shape that respects the structure.
                  Circle()
                    .fill(slice.gradient)
                    .opacity(0.8)
                    .width(200)
                    .height(200)
                })

                // === VStack (Center Text) ===
                Column() {
                  Text('Total Spent')
                    .fontColor('#718096')
                    .fontSize(14)
                  
                  Text('$' + this.totalValue.toFixed(2))
                    .fontColor('#4A5568')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                }
              }.width(200).height(200)

              // === VStack (List Items) ===
              Column() {
                // === ForEach (Budget Data) ===
                ForEach(this.budgetData, (item: BudgetItem) => {
                  // === CardView ===
                  Column() {
                    // === HStack (Card Content) ===
                    Row() {
                      // === HStack (Icon & Name) ===
                      Row() {
                        Circle()
                          .width(20)
                          .height(20)
                          .fill(item.gradient)
                        
                        Text(item.name)
                          .fontColor('#2D3748')
                          .fontSize(16)
                      }
                      
                      Blank()
                      
                      // === Text (Value) ===
                      Text('$' + item.value.toFixed(2))
                        .fontColor('#2D3748')
                        .fontSize(18)
                        .fontWeight(FontWeight.Medium)
                    }
                    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
                  }
                  .backgroundColor('#FFFFFF')
                  .borderRadius(12)
                  .margin({ bottom: 12 })
                  .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
                })
              }.padding({ left: 24, right: 24 })

              // === Spacer (Bottom Padding) ===
              Blank().height(104)
            }
          }
        }

        // === VStack (Bottom Sheet/Overlay) ===
        Column() {
          Blank()
          
          // === ZStack (Bottom Bar) ===
          Stack() {
            // === HStack (Bar Content) ===
            Row() {
              // Item 1
              Column() {
                Circle()
                  .width(24)
                  .height(24)
                  .fill(Color.Red)
                  .opacity(0.2)
                
                Text('Food')
                  .textAlign(TextAlign.Center)
                  .fontColor('#FF6B6B')
                  .fontSize(12)
              }
              
              Blank()
              
              // Item 2
              Column() {
                Circle()
                  .width(24)
                  .height(24)
                  .fill(Color.Blue)
                  .opacity(0.2)
                
                Text('Trans')
                  .textAlign(TextAlign.Center)
                  .fontColor('#4ECDC4')
                  .fontSize(12)
              }
              
              Blank()
              
              // Separator
              Rect()
                .width(56)
                .fill(Color.Transparent)
              
              Blank()
              
              // Item 3
              Column() {
                Circle()
                  .width(24)
                  .height(24)
                  .fill(Color.Yellow)
                  .opacity(0.2)
                
                Text('Util')
                  .textAlign(TextAlign.Center)
                  .fontColor('#FFE66D')
                  .fontSize(12)
              }
              
              Blank()
              
              // Item 4
              Column() {
                Circle()
                  .width(24)
                  .height(24)
                  .fill(Color.Green)
                  .opacity(0.2)
                
                Text('Other')
                  .textAlign(TextAlign.Center)
                  .fontColor('#48BB78')
                  .fontSize(12)
              }
            }
            .width('100%')
            .height(80)
            .padding({ left: 24, right: 24 })
            .backgroundColor('#FFFFFF')
            .shadow({ radius: 15, color: '#1A000000', offsetY: -5 })

            // === Button (Floating Action) ===
            Button() {
              Text('+')
                .fontColor('#FFFFFF')
                .fontSize(24)
            }
            .type(ButtonType.Circle)
            .backgroundColor('#4A5568')
            .width(48)
            .height(48)
            .offset({ y: -28 })
          }
        }
      }
    }.width('100%').height('100%')
  }
}