// MainEntry.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class MainAbility extends UIAbility {
  onCreate(want, launchParam) {
    // Set up full screen mode similar to the original
    const windowStage = this.windowStage;
    if (windowStage) {
      windowStage.loadContent('pages/Index', (err) => {
        if (err) {
          console.error('Failed to load content');
          return;
        }
        
        // Hide system bars for immersive experience
        const mainWindow = windowStage.getMainWindowSync();
        mainWindow.setWindowLayoutFullScreen(true);
      });
    }
  }
}

// pages/Index.ets
@Entry
@Component
struct TaskDashboardScreen {
  @State selectedCategory: string = 'All'
  
  build() {
    Column() {
      TopHeader()
      
      Column() {
        WelcomeSection()
        CategorySelector({ 
          onSelect: (category: string) => {
            this.selectedCategory = category
          }
        })
        RecentTasksList()
      }
      .padding({ left: 24, right: 24 })
      .layoutWeight(1)
      
      FloatingActionButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      IconButton({ icon: 'menu', size: 48 })
      
      Flex().layoutWeight(1)
      
      IconButton({ icon: 'search', size: 48 })
    }
    .width('100%')
    .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct IconButton {
  @Prop icon: string
  @Prop size: number
  
  build() {
    Button() {
      Image(this.icon === 'menu' ? $r('app.media.menu_icon') : $r('app.media.search_icon'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
    }
    .width(this.size)
    .height(this.size)
    .borderRadius(24)
    .backgroundColor('#F5F5F5')
    .onClick(() => {
      // Handle icon button click
    })
  }
}

@Component
struct WelcomeSection {
  build() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 8 })
      
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .margin({ top: 16, bottom: 32 })
  }
}

@Component
struct CategorySelector {
  @State categories: string[] = ['All', 'Work', 'Personal', 'Design']
  @State selectedIndex: number = 0
  private onSelect: (category: string) => void
  
  aboutToAppear() {
    // Initialize with first category selected
  }
  
  build() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string, index: number) => {
          CategoryChip({
            text: category,
            isSelected: index === this.selectedIndex,
            onClick: () => {
              this.selectedIndex = index
              this.onSelect(category)
            }
          })
        }, (category: string) => category)
      }
      .margin({ bottom: 24 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .barState(BarState.Off)
  }
}

@Component
struct CategoryChip {
  @Prop text: string
  @Prop isSelected: boolean
  private onClick: () => void
  
  build() {
    Button(this.text) {
      Text(this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .backgroundColor(this.isSelected ? '#212121' : '#F5F5F5')
    .borderRadius(50)
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .margin({ right: 12 })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct RecentTasksList {
  @State tasks: TaskItemData[] = [
    {
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      isChecked: true
    },
    {
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      isChecked: false
    },
    {
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      isChecked: false
    },
    {
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      isChecked: false
    }
  ]
  
  build() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })
      
      List() {
        ForEach(this.tasks, (task: TaskItemData) => {
          ListItem() {
            TaskItemComponent(task)
          }
        }, (task: TaskItemData) => task.title)
      }
      .width('100%')
      .layoutWeight(1)
    }
  }
}

interface TaskItemData {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  isChecked: boolean
}

@Component
struct TaskItemComponent {
  @State task: TaskItemData
  
  build() {
    Column() {
      Row() {
        // Icon container
        Row() {
          Image($r('app.media.calendar_icon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .width(48)
        .height(48)
        .borderRadius(14)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        
        Column() {
          Text(this.task.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.task.isChecked ? Color.Gray : Color.Black)
            .margin({ bottom: 4 })
          
          Row() {
            Text(this.task.time)
              .fontSize(12)
              .fontColor(Color.Gray)
            
            Blank().layoutWeight(1)
            
            Text(this.task.tag)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.task.tagTextColor)
              .backgroundColor(this.task.tagColor)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)
          }
        }
        .layoutWeight(1)
        .margin({ left: 16 })
        
        // Checkbox
        Checkbox({ value: this.task.isChecked })
          .onChange((isChecked: boolean) => {
            this.task.isChecked = isChecked
          })
          .width(24)
          .height(24)
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .margin({ bottom: 16 })
  }
}

@Component
struct FloatingActionButton {
  build() {
    Button() {
      Image($r('app.media.add_icon'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor('#212121')
    .position({ right: 24, bottom: 24 })
    .onClick(() => {
      // Handle add button click
    })
  }
}