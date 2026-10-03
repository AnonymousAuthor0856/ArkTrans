@Entry
@Component
struct ForumPostPage {
  @State voteState: number = 1
  @State commentText: string = ''

  private post: Post = {
    author: { name: 'user/compose_master', avatarColor: AppColors.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    votes: 1337,
    commentCount: 42
  }

  private replies: Reply[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: AppColors.secondary },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: AppColors.primary },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    }
  ]

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote
            }
          })

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.outline)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

class AppColors {
  static readonly primary: string = '#00E5FF'
  static readonly secondary: string = '#FF00AA'
  static readonly tertiary: string = '#76FF03'
  static readonly background: string = '#101024'
  static readonly surface: string = '#1C1C3A'
  static readonly surfaceVariant: string = '#282850'
  static readonly outline: string = '#44446A'
  static readonly warning: string = '#FFD600'
  static readonly onPrimary: string = '#000000'
  static readonly onSurface: string = '#E0E0FF'
}

class AppSpacing {
  static readonly xs: number = 6
  static readonly sm: number = 10
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

interface Author {
  name: string
  avatarColor: string
}

interface Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number
}

interface Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

@Component
struct UpVoteArrow {
  @Prop color: string = AppColors.outline
  @Prop arrowSize: number = 28

  build() {
    Canvas()
      .width(this.arrowSize)
      .height(this.arrowSize)
      .onReady((ctx: DrawingRenderingContext) => {
        const w: number = this.arrowSize
        const h: number = this.arrowSize
        ctx.beginPath()
        ctx.moveTo(w / 2, 0)
        ctx.lineTo(w, h / 2)
        ctx.lineTo(w / 2, h)
        ctx.lineTo(0, h / 2)
        ctx.closePath()
        ctx.fillStyle = this.color
        ctx.fill()
      })
  }
}

@Component
struct AuthorInfo {
  @Prop author: Author = { name: '', avatarColor: '#ffffff' }
  @Prop timestamp: string = ''

  build() {
    Row() {
      Stack() {
        Row()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(this.author.avatarColor)

        Row()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor('rgba(0, 0, 0, 0.2)')
      }
      .width(28)
      .height(28)

      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)
        .margin({ left: AppSpacing.sm })

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.outline)
        .margin({ left: AppSpacing.sm })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  @Prop text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
  }
}

@Component
struct PostCard {
  @Prop post: Post = {
    author: { name: '', avatarColor: '#ffffff' },
    timestamp: '',
    title: '',
    body: '',
    votes: 0,
    commentCount: 0
  }
  @Prop voteState: number = 0
  onVote: (value: number) => void = () => {}

  build() {
    Row() {
      Column() {
        Button() {
          UpVoteArrow({
            color: this.voteState === 1 ? AppColors.secondary : AppColors.outline
          })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)
          .margin({ top: AppSpacing.sm, bottom: AppSpacing.sm })

        Button() {
          UpVoteArrow({
            color: this.voteState === -1 ? AppColors.primary : AppColors.outline
          })
            .rotate({ angle: 180 })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 0 })

      Column() {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: AppSpacing.sm })

        Text(this.post.body)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('rgba(224, 224, 255, 0.8)')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: AppSpacing.sm })

        Row() {
          InfoChip({ text: this.post.commentCount.toString() + ' Comments' })
          InfoChip({ text: 'Share' })
            .margin({ left: AppSpacing.xl })
        }
        .width('100%')
        .margin({ top: AppSpacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct ReplyCard {
  @Prop reply: Reply = {
    id: 0,
    author: { name: '', avatarColor: '#ffffff' },
    timestamp: '',
    text: '',
    votes: 0
  }

  build() {
    Row() {
      Row()
        .width(3)
        .height('100%')
        .borderRadius(1.5)
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)

      Column() {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('rgba(224, 224, 255, 0.9)')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: AppSpacing.xs })

        Row() {
          InfoChip({ text: this.reply.votes.toString() + ' votes' })
          InfoChip({ text: 'Reply' })
            .margin({ left: AppSpacing.md })
        }
        .width('100%')
        .margin({ top: AppSpacing.xs })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppSpacing.md })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row()
        .width('100%')
        .height(60)
        .backgroundColor(AppColors.surface)

      Row() {
        Button() {
          Canvas()
            .width(24)
            .height(24)
            .onReady((ctx: DrawingRenderingContext) => {
              const w: number = 24
              const h: number = 24
              const cy: number = h / 2
              ctx.strokeStyle = AppColors.primary
              ctx.lineWidth = 3
              ctx.lineCap = 'round'

              ctx.beginPath()
              ctx.moveTo(w, cy)
              ctx.lineTo(w / 2, 0)
              ctx.stroke()

              ctx.beginPath()
              ctx.moveTo(w, cy)
              ctx.lineTo(w / 2, h)
              ctx.stroke()
            })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(50)
        .height(50)
        .padding(0)

        Blank()

        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Row()
          .width(50)
          .height(50)
          .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .height(60)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    }
    .width('100%')
    .height(60)
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string

  build() {
    Column() {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor('rgba(68, 68, 106, 0.3)')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(52)
            .borderRadius(AppShapes.large)
            .backgroundColor(AppColors.surfaceVariant)

          if (this.commentText === '') {
            Text('Add a comment...')
              .fontSize(18)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.outline)
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          }

          TextInput({ text: this.commentText, placeholder: '' })
            .fontSize(18)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .height(52)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.commentText = value
            })
            .defaultFocus(false)
        }
        .layoutWeight(1)
        .height(52)

        Button('POST')
        .type(ButtonType.Normal)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .height(52)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .margin({ left: AppSpacing.md })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
  }
}
