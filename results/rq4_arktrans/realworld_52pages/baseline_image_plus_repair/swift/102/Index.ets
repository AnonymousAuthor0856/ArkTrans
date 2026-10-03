import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct CategoryEditView {
  @State categoryName: string = ''
  @State categoryColor: Color = Color.Gray
  @State isFocused: boolean = false
  private navPathStack: NavPathStack = new NavPathStack()
  
  build() {
    Column() {
      // Navigation Bar
      Row() {
        Text("Cancel")
          .font({ size: 17, weight: 400 })
          .foregroundColor('#8B6914')
          .onClick(() => {
            this.navPathStack.pop()
          })
        
        Blank()
        
        Text("OK")
          .font({ size: 17, weight: 400 })
          .foregroundColor('#8B6914')
          .onClick(() => {
            // Handle OK action
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 50, bottom: 20 })
      
      // Title
      Text("Create New Category")
        .font({ size: 34, weight: 700 })
        .margin({ top: 20, bottom: 30 })
        .alignSelf(ItemAlign.Start)
        .margin({ left: 20 })
      
      // Input Field and Color Picker
      Row() {
        // Custom TextField with gradient background
        Column() {
          TextInput({ placeholder: 'Name your category...', text: this.categoryName })
            .type(InputType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .onChange((value: string) => {
              this.categoryName = value
            })
            .onFocus(() => {
              this.isFocused = true
            })
            .onBlur(() => {
              this.isFocused = false
            })
        }
        .width('75%')
        .height(50)
        .borderRadius(25)
        .linearGradient({
          angle: 180,
          colors: [['#E0E0E0', 0], ['#C0C0C0', 1]]
        })
        .shadow({ radius: 5, color: '#00000020', offsetX: 0, offsetY: 2 })
        
        // Color Picker Button
        Image($r('app.media.color_picker_icon'))
          .width(40)
          .height(40)
          .margin({ left: 15 })
          .onClick(() => {
            // Open color picker
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      .margin({ top: 10 })
      
      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}