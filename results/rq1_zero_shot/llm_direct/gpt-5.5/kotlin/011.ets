const NAME: string = '008_ForumPost_en'
const UI_TYPE: string = 'Social Forum Post'
const STYLE_THEME: string = 'Dark Neon'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#00E5FF'
  static readonly secondary: string = '#FF00AA'
  static readonly tertiary: string = '#76FF03'
  static readonly background: string = '#101024'
  static readonly surface: string = '#1C1C3A'
  static readonly surfaceVariant: string = '#282850'
  static readonly outline: string = '#44446A'
  static readonly success: string = '#00C853'
  static readonly warning: string = '#FFD600'
  static readonly error: string = '#FF1744'
  static readonly onPrimary: string = '#000000'
  static readonly onSecondary: string = '#000000'
  static readonly onTertiary: string = '#000000'
  static readonly onBackground: string = '#E0E0FF'
  static readonly onSurface: string = '#E0E0FF'
  static readonly transparent: string = 'rgba(0,0,0,0)'
  static readonly onSurface80: string = 'rgba(224,224,255,0.8)'
  static readonly onSurface90: string = 'rgba(224,224,255,0.9)'
  static readonly black20: string = 'rgba(0,0,0,0.2)'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class Author {
  name: string
  avatarColor: string

  constructor(name: string, avatarColor: string) {
    this.name = name
    this.avatarColor = avatarColor
  }
}

class Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id
    this.author = author
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

class Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author
    this.timestamp = timestamp
    this.title = title
    this.body = body
    this.votes = votes
    this.commentCount = commentCount
  }
}

@Component
struct UpVoteArrow {
  color: string = AppColors.outline

  build() {
    Text('◆')
      .fontSize(24)
      .fontColor(this.color)
      .width(24)
      .height(24)
      .lineHeight(24)
      .textAlign(TextAlign.Center)
  }
}

@Component
struct TopBar {
  build() {
    Stack() {
      Text('r/jetpackcompose')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .align(Alignment.Center)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Stack() {
          Text('‹')
            .fontSize(36)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.primary)
            .lineHeight(40)
            .textAlign(TextAlign.Center)
        }
        .width(40)
        .height(40)
      }
      .width(48)
      .height(48)
      .backgroundColor(AppColors.transparent)
      .position({ x: 4, y: 4 })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct BottomBar {
  build() {
    Row({ space: AppSpacing.md }) {
      Row() {
        Text('Add a comment...')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.outline)
      }
      .layoutWeight(1)
      .height(48)
      .borderRadius(16)
      .backgroundColor(AppColors.surfaceVariant)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('POST')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .letterSpacing(0.5)
      }
      .height(48)
      .borderRadius(16)
      .backgroundColor(AppColors.primary)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', AppColors.primary)
  timestamp: string = ''

  build() {
    Row({ space: AppSpacing.sm }) {
      Stack() {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.black20)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(this.author.avatarColor)

      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)
        .letterSpacing(0.5)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.outline)
        .letterSpacing(0.5)
        .maxLines(1)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
      .letterSpacing(0.5)
  }
}

@Component
struct PostCard {
  post: Post = new Post(new Author('', AppColors.primary), '', '', '', 0, 0)
  voteState: number = 1
  onVote: (value: number) => void = () => {
  }

  build() {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          UpVoteArrow({
            color: this.voteState === 1 ? AppColors.secondary : AppColors.outline
          })
        }
        .width(48)
        .height(48)
        .backgroundColor(AppColors.transparent)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          UpVoteArrow({
            color: this.voteState === -1 ? AppColors.primary : AppColors.outline
          })
            .rotate({ angle: 180 })
        }
        .width(48)
        .height(48)
        .backgroundColor(AppColors.transparent)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
        AuthorInfo({
          author: this.post.author,
          timestamp: this.post.timestamp
        })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text(this.post.body)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface80)
          .lineHeight(24)

        Blank()
          .height(AppSpacing.sm)

        Row({ space: AppSpacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .padding(AppSpacing.lg)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author('', AppColors.primary), '', '', 0)

  getLineColor(): string {
    if (this.reply.author.avatarColor === AppColors.secondary) {
      return 'rgba(255,0,170,0.5)'
    }
    if (this.reply.author.avatarColor === AppColors.primary) {
      return 'rgba(0,229,255,0.5)'
    }
    if (this.reply.author.avatarColor === AppColors.warning) {
      return 'rgba(255,214,0,0.5)'
    }
    if (this.reply.author.avatarColor === AppColors.tertiary) {
      return 'rgba(118,255,3,0.5)'
    }
    return 'rgba(224,224,255,0.5)'
  }

  build() {
    Row({ space: AppSpacing.md }) {
      Column()
        .width(2)
        .height('100%')
        .borderRadius(2)
        .backgroundColor(this.getLineColor())

      Column({ space: AppSpacing.xs }) {
        AuthorInfo({
          author: this.reply.author,
          timestamp: this.reply.timestamp
        })

        Text(this.reply.text)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface90)
          .lineHeight(24)

        Row({ space: AppSpacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .alignItems(VerticalAlign.Stretch)
  }
}

@Entry
@Component
struct Index {
  @State voteState: number = 1

  private post: Post = new Post(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\\\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  )

  private replies: Reply[] = [
    new Reply(
      1,
      new Author('dev/android_fan', AppColors.secondary),
      '7h ago',
      'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      25
    ),
    new Reply(
      2,
      new Author('ux/designer_jane', AppColors.primary),
      '5h ago',
      'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      18
    ),
    new Reply(
      3,
      new Author('newbie/coder', AppColors.warning),
      '2h ago',
      'I found it a bit overwhelming at first. Any tips for organizing the file?',
      3
    )
  ]

  build() {
    Column() {
      TopBar()

      List() {
        ListItem() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (value: number) => {
              this.voteState = value
            }
          })
        }

        ListItem() {
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.outline)
            .letterSpacing(0.5)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
        }

        ForEach(this.replies, (reply: Reply) => {
          ListItem() {
            ReplyCard({ reply: reply })
          }
        }, (reply: Reply) => reply.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}