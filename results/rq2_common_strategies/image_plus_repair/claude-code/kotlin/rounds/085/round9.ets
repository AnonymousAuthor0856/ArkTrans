import promptAction from '@ohos.promptAction';

@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: IconType.CALENDAR, urgency: 'Today', isChecked: false },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: IconType.NOTIFICATIONS, urgency: 'Tomorrow', isChecked: false },
  ];

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, expanded: false },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, expanded: false },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, expanded: false },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, expanded: false },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, expanded: false },
  ];

  @State selectedNav: number = 0;

  private readonly BotanyWhite: string = '#FFFFFF';
  private readonly BotanySurface: string = '#FAFAFA';
  private readonly BotanyTextPrimary: string = '#1A1C19';
  private readonly BotanyTextSecondary: string = '#757575';
  private readonly BotanyAccent: string = '#2E5E4E';
  private readonly BotanyBorder: string = '#EEEEEE';

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        this.MainContent()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.BotanyWhite)

      Stack() {
        Circle({ width: 56, height: 56 })
          .fill(this.BotanyTextPrimary)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
        Text('+')
          .fontSize(32)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .margin({ right: 24, bottom: 80 })
      .onClick(() => {
        promptAction.showToast({ message: 'Add Plant', duration: 1000 });
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BotanyWhite)
  }

  @Builder
  TopBar() {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.BotanySurface)
        MenuIcon()
      }
      .width(40)
      .height(40)
      .onClick(() => {})

      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.BotanySurface)
        SearchIcon()
      }
      .width(40)
      .height(40)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
  }

  @Builder
  MainContent() {
    List() {
      ListItem() {
        Column() {
          Text('Good Morning,')
            .fontSize(18)
            .fontColor(this.BotanyTextSecondary)
            .margin({ bottom: 4 })
          Text('My Jungle')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.BotanyTextPrimary)
            .letterSpacing(-1)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }

      ListItem() {
        Column() {
          this.SectionHeader('Pending Tasks')

          List({ space: 16 }) {
            ForEach(this.tasks, (task: Task, index: number) => {
              ListItem() {
                this.TaskCard(task, index)
              }
            }, (task: Task) => task.id.toString())
          }
          .listDirection(Axis.Horizontal)
          .padding({ left: 24, right: 24 })
          .height(180)
        }
        .width('100%')
      }

      ListItem() {
        this.SectionHeader('Your Collection')
      }

      ForEach(this.plants, (plant: Plant, index: number) => {
        ListItem() {
          this.PlantListItem(plant, index)
        }
      }, (plant: Plant) => plant.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .padding({ bottom: 8 })
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.BotanyTextPrimary)
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskCard(task: Task, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(task.isChecked ? this.BotanyAccent : '#FFFFFF')
          if (task.icon === IconType.CALENDAR) {
            CalendarIcon({ color: task.isChecked ? '#FFFFFF' : this.BotanyTextPrimary })
          } else if (task.icon === IconType.NOTIFICATIONS) {
            NotificationsIcon({ color: task.isChecked ? '#FFFFFF' : this.BotanyTextPrimary })
          }
        }
        .width(40)
        .height(40)
      }
      .width('100%')

      Column() {
        Text(task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.BotanyTextPrimary)
        Text(task.plantName)
          .fontSize(14)
          .fontColor(this.BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 2 })

        Stack({ alignContent: Alignment.Start }) {
          Text(task.isChecked ? 'DONE' : task.urgency)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.isChecked ? '#FFFFFF' : this.BotanyTextPrimary)
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })
        }
        .backgroundColor(task.isChecked ? this.BotanyAccent : '#E0E0E0')
        .borderRadius(8)
        .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(this.BotanySurface)
    .borderRadius(24)
    .border({
      width: task.isChecked ? 2 : 1,
      color: task.isChecked ? this.BotanyAccent : this.BotanyBorder
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      this.tasks[index].isChecked = !this.tasks[index].isChecked;
    })
  }

  @Builder
  PlantListItem(plant: Plant, index: number) {
    Row() {
      Stack() {
        Stack() {
          HeartIcon({ color: plant.daysUntilWater === 0 ? this.BotanyAccent : '#CCCCCC' })
        }
        .width(56)
        .height(56)
        .backgroundColor('#EEEEEE')
        .borderRadius(12)
      }
      .width(56)
      .height(56)

      Column() {
        Text(plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.BotanyTextPrimary)
        Text(plant.scientificName)
          .fontSize(12)
          .fontColor(this.BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (plant.expanded) {
          Row() {
            LocationIcon({ color: this.BotanyTextSecondary })
            Text(plant.location)
              .fontSize(11)
              .fontColor(this.BotanyTextSecondary)
              .margin({ left: 4 })
          }
          .margin({ top: 8 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Column() {
        if (plant.daysUntilWater === 0) {
          CheckIcon({ color: this.BotanyAccent })
          Text('Water')
            .fontSize(11)
            .fontColor(this.BotanyAccent)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 2 })
        } else {
          Text(`${plant.daysUntilWater} days`)
            .fontSize(11)
            .fontColor(this.BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.plants[index].expanded = !this.plants[index].expanded;
    })
  }

  @Builder
  BottomBar() {
    Row() {
      this.NavItem(IconType.HOME, 0)
      this.NavItem(IconType.CALENDAR, 1)
      Blank()
      this.NavItem(IconType.NOTIFICATIONS, 2)
      this.NavItem(IconType.SETTINGS, 3)
    }
    .width('100%')
    .height(72)
    .backgroundColor(this.BotanyWhite)
    .padding({ left: 48, right: 48 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavItem(iconType: IconType, index: number) {
    Column() {
      if (iconType === IconType.HOME) {
        HomeIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      } else if (iconType === IconType.CALENDAR) {
        CalendarIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      } else if (iconType === IconType.NOTIFICATIONS) {
        NotificationsIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      } else if (iconType === IconType.SETTINGS) {
        SettingsIcon({ color: this.selectedNav === index ? this.BotanyTextPrimary : this.BotanyTextSecondary })
      }
    }
    .opacity(this.selectedNav === index ? 1.0 : 0.4)
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedNav = index;
    })
  }
}

interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  expanded: boolean;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  icon: IconType;
  urgency: string;
  isChecked: boolean;
}

enum IconType {
  HOME,
  CALENDAR,
  NOTIFICATIONS,
  SETTINGS,
}

@Component
struct MenuIcon {
  build() {
    Column() {
      Rect({ width: 18, height: 2 }).fill('#1A1C19').margin({ bottom: 3 })
      Rect({ width: 18, height: 2 }).fill('#1A1C19').margin({ bottom: 3 })
      Rect({ width: 18, height: 2 }).fill('#1A1C19')
    }
    .width(18)
    .height(14)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct SearchIcon {
  build() {
    Stack() {
      Circle({ width: 12, height: 12 })
        .stroke('#1A1C19')
        .fill(Color.Transparent)
        .margin({ right: 4, bottom: 4 })
      Line()
        .startPoint([0, 0])
        .endPoint([6, 6])
        .stroke('#1A1C19')
        .margin({ left: 8, top: 8 })
    }
    .width(20)
    .height(20)
    .alignContent(Alignment.Center)
  }
}

@Component
struct HomeIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Column() {
      Row() {
        Column()
          .width(2)
          .height(10)
          .backgroundColor(this.color)
          .margin({ right: 6 })
        Column()
          .width(2)
          .height(10)
          .backgroundColor(this.color)
      }
      .margin({ top: 10 })

      Row() {
        Column()
          .width(2)
          .height(6)
          .backgroundColor(this.color)
          .margin({ right: 4 })
        Column()
          .width(4)
          .height(6)
          .backgroundColor(this.color)
          .margin({ right: 4 })
        Column()
          .width(2)
          .height(6)
          .backgroundColor(this.color)
      }
      .margin({ top: 2, left: 6 })
    }
    .width(24)
    .height(24)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct CalendarIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Column() {
      Row() {
        Column()
          .width(2)
          .height(3)
          .backgroundColor(this.color)
          .margin({ left: 4 })
        Blank()
        Column()
          .width(2)
          .height(3)
          .backgroundColor(this.color)
          .margin({ right: 4 })
      }
      .width(20)
      .height(4)

      Column()
        .width(15)
        .height(1)
        .backgroundColor(this.color)
        .margin({ top: 1, bottom: 2 })

      Row() {
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
          .margin({ right: 2 })
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
          .margin({ right: 2 })
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
          .margin({ right: 2 })
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
      }
      .margin({ bottom: 2 })

      Row() {
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
          .margin({ right: 2 })
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
          .margin({ right: 2 })
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
          .margin({ right: 2 })
        Column()
          .width(2)
          .height(2)
          .backgroundColor(this.color)
      }
    }
    .width(20)
    .height(20)
    .border({ width: 1.5, color: this.color })
    .borderRadius(3)
    .padding(2)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct NotificationsIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Column() {
      Circle({ width: 10, height: 6 })
        .fill(this.color)
        .margin({ top: 3 })

      Column()
        .width(6)
        .height(6)
        .backgroundColor(this.color)
        .margin({ top: -1 })

      Row() {
        Column()
          .width(8)
          .height(6)
          .backgroundColor(this.color)
          .margin({ right: -1 })
        Column()
          .width(2)
          .height(6)
          .backgroundColor(this.color)
        Column()
          .width(8)
          .height(6)
          .backgroundColor(this.color)
          .margin({ left: -1 })
      }
      .margin({ top: -1 })

      Circle({ width: 4, height: 2 })
        .fill(this.color)
        .margin({ top: -1 })
    }
    .width(20)
    .height(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct SettingsIcon {
  @Prop color: string = '#1A1C19';

  build() {
    Stack() {
      Circle({ width: 18, height: 18 })
        .stroke(this.color, width: 2 })
        .fill(Color.Transparent)

      Circle({ width: 12, height: 12 })
        .stroke(this.color, width: 1.5 })
        .fill(Color.Transparent)

      // Gear teeth as 8 small rectangles
      ForEach([0, 45, 90, 135, 180, 225, 270, 315], (angle: number) => {
        Column()
          .width(2)
          .height(4)
          .backgroundColor(this.color)
          .rotate({ angle: angle, centerX: '50%', centerY: '400%' })
      })
    }
    .width(24)
    .height(24)
    .alignContent(Alignment.Center)
  }
}

@Component
struct HeartIcon {
  @Prop color: string = '#CCCCCC';

  build() {
    Column() {
      Row() {
        Circle({ width: 8, height: 8 }).fill(this.color)
        Circle({ width: 8, height: 8 }).fill(this.color).margin({ left: -2 })
      }
      .margin({ top: 4 })

      Row() {
        Column()
          .width(8)
          .height(6)
          .backgroundColor(this.color)
          .margin({ right: -1 })
        Column()
          .width(2)
          .height(6)
          .backgroundColor(this.color)
        Column()
          .width(8)
          .height(6)
          .backgroundColor(this.color)
          .margin({ left: -1 })
      }
      .margin({ top: -2 })

      Column()
        .width(6)
        .height(4)
        .backgroundColor(this.color)
        .margin({ top: -1 })
    }
    .width(24)
    .height(24)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct CheckIcon {
  @Prop color: string = '#2E5E4E';

  build() {
    Stack() {
      // Left stroke
      Line()
        .startPoint([3, 12])
        .endPoint([9, 18])
        .stroke(this.color, width: 2.5 })
        .strokeLineCap(LineCapStyle.Round)
      // Right stroke
      Line()
        .startPoint([9, 18])
        .endPoint([20, 7])
        .stroke(this.color, width: 2.5 })
        .strokeLineCap(LineCapStyle.Round)
    }
    .width(24)
    .height(24)
    .alignContent(Alignment.Center)
  }
}

@Component
struct LocationIcon {
  @Prop color: string = '#757575';

  build() {
    Stack() {
      Circle({ width: 10, height: 10 })
        .fill(this.color)
        .margin({ bottom: 2 })
      Circle({ width: 10, height: 10 })
        .fill(this.color)
        .margin({ top: 2 })
      Column()
        .width(10)
        .height(6)
        .backgroundColor(this.color)
      Circle({ width: 3, height: 3 })
        .fill('#FFFFFF')
    }
    .width(12)
    .height(12)
    .alignContent(Alignment.Center)
  }
}
