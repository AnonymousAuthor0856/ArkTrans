

package com.shub39.grit.shared.ui.habit.ui

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.animateContentSize
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.staggeredgrid.LazyVerticalStaggeredGrid
import androidx.compose.foundation.lazy.staggeredgrid.StaggeredGridCells
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import kotlin.random.Random
import kotlinx.datetime.*
import kotlin.math.roundToInt


data class Habit(
    val id: Long = 0,
    val title: String,
    val description: String = "",
    val time: LocalDateTime = LocalDateTime(2026, 7, 17, 8, 0, 0),
    val days: Set<DayOfWeek> = DayOfWeek.entries.toSet(),
    val reminder: Boolean = false,
)

data class HabitStatus(val id: Long = 0, val habitId: Long, val date: LocalDate)

data class HabitWithAnalytics(
    val habit: Habit,
    val consistency: Float = 0f,
    val statuses: List<HabitStatus> = emptyList(),
    val currentStreak: Int = 0,
    val bestStreak: Int = 0,
    val startedDaysAgo: Long = 0,
)

data class OverallAnalytics(
    val heatMapData: Map<LocalDate, Int> = emptyMap(),
    val consistency: Float = 0f,
    val topHabits: List<Pair<String, Float>> = emptyList(),
    val completedHabits: Pair<LocalDate, List<String>>? = null,
)



private val today: LocalDate = LocalDate(2026, 7, 17)

private fun randomStatuses(habitId: Long, daysBack: Int = 90): List<HabitStatus> =
    (0..daysBack).mapNotNull { offset ->
        val date = today.minus(offset, DateTimeUnit.DAY)
        if (Random.nextDouble() > 0.35) HabitStatus(habitId = habitId, date = date) else null
    }

private val mockHabits = listOf(
    Habit(
        id = 1, title = "Morning Run",
        description = "Run 5km every morning to stay fit",
        days = setOf(DayOfWeek.MONDAY, DayOfWeek.TUESDAY, DayOfWeek.WEDNESDAY, DayOfWeek.THURSDAY, DayOfWeek.FRIDAY),
        reminder = true,
    ),
    Habit(
        id = 2, title = "Read 30 Minutes",
        description = "Read technical books before sleep",
        days = DayOfWeek.entries.toSet(),
        reminder = true,
    ),
    Habit(
        id = 3, title = "Meditate",
        description = "Mindfulness meditation to relax",
        days = DayOfWeek.entries.toSet(),
        reminder = false,
    ),
    Habit(
        id = 4, title = "Drink 8 Glasses of Water",
        description = "",
        days = DayOfWeek.entries.toSet(),
        reminder = false,
    ),
    Habit(
        id = 5, title = "Journal",
        description = "Write down today's events and thoughts",
        days = DayOfWeek.entries.toSet(),
        reminder = true,
    ),
    Habit(
        id = 6, title = "Weekend Hiking",
        description = "Outdoor hiking every Sat & Sun",
        days = setOf(DayOfWeek.SATURDAY, DayOfWeek.SUNDAY),
        reminder = false,
    ),
)

private val mockHabitsWithAnalytics: List<HabitWithAnalytics> = mockHabits.map { habit ->
    val statuses = randomStatuses(habit.id)
    val streak = (Random.nextDouble() * 30).toInt()
    HabitWithAnalytics(
        habit = habit,
        consistency = (Random.nextDouble().toFloat() * 0.6f + 0.4f).coerceAtMost(1f),
        statuses = statuses,
        currentStreak = streak,
        bestStreak = streak + (Random.nextDouble() * 20).toInt(),
        startedDaysAgo = (Random.nextDouble() * 180 + 30).toLong(),
    )
}

private val mockOverallAnalytics: OverallAnalytics = OverallAnalytics(
    consistency = 0.72f,
    heatMapData = buildMap {
        for (i in 0..365 step (1..5).random()) {
            val date = today.minus(i, DateTimeUnit.DAY)
            put(date, (1..mockHabits.size).random())
        }
    },
    topHabits = mockHabits.take(3).map {
        it.title to (Random.nextDouble().toFloat() * 0.3f + 0.6f).coerceAtMost(1f)
    },
)

private val todayCompletedIds = mockHabitsWithAnalytics
    .filter { it.statuses.any { s -> s.date == today } }
    .map { it.habit.id }


private enum class HabitScreen { HabitList, Analytics, OverallAnalytics, Calendar, CalendarHeatMap }

@Composable
fun HabitsGraphPreview() {
    var currentScreen by remember { mutableStateOf(HabitScreen.HabitList) }
    var selectedHabitId by remember { mutableStateOf<Long?>(null) }

    val selectedHabit = mockHabitsWithAnalytics.find { it.habit.id == selectedHabitId }

    AnimatedContent(targetState = currentScreen) { screen ->
        when (screen) {
            HabitScreen.HabitList -> HabitsListPage(
                habits = mockHabitsWithAnalytics,
                completedIds = todayCompletedIds,
                onAnalyticsClick = { id ->
                    selectedHabitId = id
                    currentScreen = HabitScreen.Analytics
                },
                onOverallAnalytics = { currentScreen = HabitScreen.OverallAnalytics },
            )

            HabitScreen.Analytics -> selectedHabit?.let { habit ->
                AnalyticsPage(
                    habitWithAnalytics = habit,
                    onBack = { currentScreen = HabitScreen.HabitList },
                    onCalendarClick = { currentScreen = HabitScreen.Calendar },
                )
            }

            HabitScreen.OverallAnalytics -> OverallAnalyticsPage(
                analytics = mockOverallAnalytics,
                totalHabits = mockHabits.size,
                onBack = { currentScreen = HabitScreen.HabitList },
                onCalendarHeatMap = { currentScreen = HabitScreen.CalendarHeatMap },
            )

            HabitScreen.Calendar -> selectedHabit?.let { habit ->
                CalendarPage(
                    habitWithAnalytics = habit,
                    onBack = { currentScreen = HabitScreen.Analytics },
                )
            }

            HabitScreen.CalendarHeatMap -> CalendarHeatMapPage(
                analytics = mockOverallAnalytics,
                onBack = { currentScreen = HabitScreen.OverallAnalytics },
            )
        }
    }
}









@Preview(name = "Calendar HeatMap", showBackground = true)
@Composable
private fun CalendarHeatMapPreview() {
    MaterialTheme {
        CalendarHeatMapPage(
            analytics = mockOverallAnalytics,
            onBack = {},
        )
    }
}





@Composable
private fun HabitsListPage(
    habits: List<HabitWithAnalytics>,
    completedIds: List<Long>,
    onAnalyticsClick: (Long) -> Unit,
    onOverallAnalytics: () -> Unit,
) {
    Scaffold(
        topBar = {
            LargeTopAppBar(
                title = { Text("Habits", fontWeight = FontWeight.Bold) },
                colors = TopAppBarDefaults.largeTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
            )
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = onOverallAnalytics,
                containerColor = MaterialTheme.colorScheme.primaryContainer,
            ) {
                Text("⭐")
            }
        },
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding)) {
            Text(
                "${completedIds.size}/${habits.size} completed",
                style = MaterialTheme.typography.labelLarge,
                modifier = Modifier.padding(horizontal = 16.dp, vertical = 4.dp),
                color = MaterialTheme.colorScheme.onSurfaceVariant,
            )

            LazyColumn(
                modifier = Modifier.fillMaxSize(),
                contentPadding = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp),
            ) {
                if (habits.isEmpty()) {
                    item {
                        Box(
                            modifier = Modifier.fillMaxWidth().padding(top = 150.dp),
                            contentAlignment = Alignment.Center,
                        ) {
                            Text(
                                "No habits yet. Tap + to add one.",
                                color = MaterialTheme.colorScheme.onSurfaceVariant,
                            )
                        }
                    }
                }

                itemsIndexed(habits, key = { _, h -> h.habit.id }) { _, hwa ->
                    val completed = hwa.habit.id in completedIds
                    val todayValid = today.dayOfWeek in hwa.habit.days

                    HabitCardInline(
                        habitWithAnalytics = hwa,
                        completed = completed,
                        todayValid = todayValid,
                        onToggle = { },
                        onAnalytics = { onAnalyticsClick(hwa.habit.id) },
                    )
                }
            }
        }
    }
}


@Composable
private fun HabitCardInline(
    habitWithAnalytics: HabitWithAnalytics,
    completed: Boolean,
    todayValid: Boolean,
    onToggle: () -> Unit,
    onAnalytics: () -> Unit,
) {
    val habit = habitWithAnalytics.habit

    val bgColor by animateColorAsState(
        if (completed) MaterialTheme.colorScheme.primaryContainer
        else MaterialTheme.colorScheme.surfaceContainer,
        label = "bgColor",
    )
    val contentColor by animateColorAsState(
        if (completed) MaterialTheme.colorScheme.onPrimaryContainer
        else MaterialTheme.colorScheme.onSurface,
        label = "contentColor",
    )

    var expanded by remember { mutableStateOf(false) }

    Card(
        onClick = {
            if (todayValid) onToggle()
            else expanded = !expanded
        },
        colors = CardDefaults.outlinedCardColors(containerColor = bgColor, contentColor = contentColor),
        shape = RoundedCornerShape(20.dp),
        modifier = Modifier.animateContentSize(),
    ) {
        Column {
            ListItem(
                headlineContent = {
                    Text(
                        habit.title,
                        style = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.Bold),
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                    )
                },
                supportingContent = {
                    if (habit.reminder) {
                        Text(
                            "${habit.time.hour}:${habit.time.minute.toString().padStart(2, '0')} reminder",
                            style = MaterialTheme.typography.labelMedium,
                        )
                    }
                },
                leadingContent = {
                    if (completed) {
                        
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .clip(CircleShape)
                                .background(MaterialTheme.colorScheme.primary),
                            contentAlignment = Alignment.Center,
                        ) {
                            Text("✓", color = MaterialTheme.colorScheme.onPrimary) 
                        }
                    } else {
                        
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .border(2.dp, contentColor.copy(alpha = 0.5f), CircleShape),
                        )
                    }
                },
                trailingContent = {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Text(
                            "${habitWithAnalytics.currentStreak}",
                            style = MaterialTheme.typography.labelLarge,
                        )
                        Spacer(Modifier.width(2.dp))
                        Text("🔥", style = MaterialTheme.typography.labelMedium) 

                        Spacer(Modifier.width(12.dp))

                        FilledTonalIconButton(
                            onClick = onAnalytics,
                            modifier = Modifier.size(36.dp),
                        ) {
                            Text("ℹ", modifier = Modifier.size(18.dp)) 
                        }
                    }
                },
            )

            
            AnimatedContent(targetState = expanded, label = "weekStrip") { isExpanded ->
                if (isExpanded) {
                    WeekStripInline(
                        statuses = habitWithAnalytics.statuses,
                        habitDays = habit.days,
                        contentColor = contentColor,
                    )
                }
            }
        }
    }
}

@Composable
private fun WeekStripInline(
    statuses: List<HabitStatus>,
    habitDays: Set<DayOfWeek>,
    contentColor: Color,
) {
    val weekDays = (-6..0).map { today.plus((-it), DateTimeUnit.DAY) }
    val doneDates = statuses.map { it.date }.toSet()

    Row(
        modifier = Modifier.fillMaxWidth().padding(horizontal = 12.dp, vertical = 4.dp),
        horizontalArrangement = Arrangement.SpaceEvenly,
    ) {
        weekDays.forEach { date ->
            val done = date in doneDates
            val valid = date.dayOfWeek in habitDays && date <= today

            Box(
                modifier = Modifier
                    .size(36.dp)
                    .clip(RoundedCornerShape(12.dp))
                    .background(if (done) MaterialTheme.colorScheme.primary else Color.Transparent)
                    .clickable(enabled = valid) { },
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    date.dayOfMonth.toString(),
                    style = MaterialTheme.typography.labelSmall,
                    fontWeight = if (today == date) FontWeight.Bold else FontWeight.Normal,
                    color = when {
                        done -> MaterialTheme.colorScheme.onPrimary
                        !valid -> contentColor.copy(alpha = 0.3f)
                        else -> contentColor
                    },
                )
            }
        }
    }
}


@Composable
private fun AnalyticsPage(
    habitWithAnalytics: HabitWithAnalytics,
    onBack: () -> Unit,
    onCalendarClick: () -> Unit,
) {
    val habit = habitWithAnalytics.habit

    Scaffold(
        topBar = {
            MediumTopAppBar(
                title = { Text(habit.title, maxLines = 1, overflow = TextOverflow.Ellipsis) },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←") 
                    }
                },
            )
        },
    ) { padding ->
        LazyVerticalStaggeredGrid(
            modifier = Modifier.fillMaxSize().padding(padding),
            columns = StaggeredGridCells.Adaptive(360.dp),
            contentPadding = PaddingValues(16.dp),
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            verticalItemSpacing = 12.dp,
        ) {
            item { StatCardsInline(habitWithAnalytics) }
            item { WeeklyHeatMapInline(statuses = habitWithAnalytics.statuses) }
            item { CalendarPreviewCardInline(onCalendarClick = onCalendarClick) }
            item { WeeklyTrendCardInline() }
        }
    }
}

@Composable
private fun StatCardsInline(hwa: HabitWithAnalytics) {
    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            StatCard("Consistency", "${(hwa.consistency * 100).roundToInt()}%", Modifier.weight(1f))
            StatCard("Current Streak", "${hwa.currentStreak} days", Modifier.weight(1f))
        }
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            StatCard("Best Streak", "${hwa.bestStreak} days", Modifier.weight(1f))
            StatCard("Started", "${hwa.startedDaysAgo} days ago", Modifier.weight(1f))
        }
    }
}

@Composable
private fun StatCard(title: String, value: String, modifier: Modifier = Modifier) {
    Card(modifier = modifier, shape = RoundedCornerShape(16.dp), colors = CardDefaults.outlinedCardColors()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(title, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
            Spacer(Modifier.height(4.dp))
            Text(
                value,
                style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold),
                color = MaterialTheme.colorScheme.primary,
            )
        }
    }
}

@Composable
private fun WeeklyHeatMapInline(statuses: List<HabitStatus>) {
    val doneSet = statuses.map { it.date }.toSet()
    val days = (89 downTo 0).map { today.minus(it, DateTimeUnit.DAY) }

    Card(shape = RoundedCornerShape(16.dp), colors = CardDefaults.outlinedCardColors()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text("Completion Heatmap", style = MaterialTheme.typography.titleSmall)
            Spacer(Modifier.height(12.dp))
            val dayOfWeekGroups = days.groupBy { it.dayOfWeek }
            DayOfWeek.entries.forEach { dow ->
                Row(horizontalArrangement = Arrangement.spacedBy(2.dp)) {
                    dayOfWeekGroups[dow]?.take(13)?.forEach { date ->
                        val done = date in doneSet
                        Box(
                            modifier = Modifier
                                .size(14.dp)
                                .clip(RoundedCornerShape(3.dp))
                                .background(
                                    if (done) MaterialTheme.colorScheme.primary
                                    else MaterialTheme.colorScheme.surfaceContainerHighest,
                                ),
                        )
                    }
                }
                Spacer(Modifier.height(2.dp))
            }
        }
    }
}

@Composable
private fun CalendarPreviewCardInline(onCalendarClick: () -> Unit) {
    Card(
        onClick = onCalendarClick,
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.outlinedCardColors(),
    ) {
        Row(
            modifier = Modifier.padding(16.dp).fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
        ) {
            Text("Calendar View", style = MaterialTheme.typography.titleSmall)
            Text("→") 
        }
    }
}

@Composable
private fun WeeklyTrendCardInline() {
    Card(shape = RoundedCornerShape(16.dp), colors = CardDefaults.outlinedCardColors()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text("Weekly Activity", style = MaterialTheme.typography.titleSmall)
            Spacer(Modifier.height(12.dp))
            Row(
                modifier = Modifier.fillMaxWidth().height(100.dp),
                horizontalArrangement = Arrangement.SpaceEvenly,
                verticalAlignment = Alignment.Bottom,
            ) {
                repeat(12) {
                    val h = (20..100).random().dp
                    Box(
                        modifier = Modifier
                            .width(18.dp).height(h)
                            .clip(RoundedCornerShape(topStart = 4.dp, topEnd = 4.dp))
                            .background(MaterialTheme.colorScheme.primary.copy(alpha = 0.7f)),
                    )
                }
            }
        }
    }
}


@Composable
private fun OverallAnalyticsPage(
    analytics: OverallAnalytics,
    totalHabits: Int,
    onBack: () -> Unit,
    onCalendarHeatMap: () -> Unit,
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Overall Analytics", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←") 
                    }
                },
            )
        },
    ) { padding ->
        LazyVerticalStaggeredGrid(
            modifier = Modifier.fillMaxSize().padding(padding),
            columns = StaggeredGridCells.Adaptive(360.dp),
            contentPadding = PaddingValues(16.dp),
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            verticalItemSpacing = 12.dp,
        ) {
            item {
                Card(shape = RoundedCornerShape(16.dp), colors = CardDefaults.outlinedCardColors()) {
                    Row(
                        modifier = Modifier.padding(24.dp).fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceEvenly,
                        verticalAlignment = Alignment.CenterVertically,
                    ) {
                        Box(contentAlignment = Alignment.Center) {
                            CircularProgressIndicator(
                                progress = { analytics.consistency },
                                strokeCap = StrokeCap.Round,
                                strokeWidth = 24.dp,
                                modifier = Modifier.size(160.dp),
                            )
                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                Text(
                                    "${(analytics.consistency * 100).roundToInt()}%",
                                    style = MaterialTheme.typography.headlineSmall.copy(
                                        fontWeight = FontWeight.Bold,
                                        color = MaterialTheme.colorScheme.primary,
                                    ),
                                )
                                Text("Consistency", style = MaterialTheme.typography.labelSmall)
                            }
                        }

                        if (analytics.topHabits.isNotEmpty()) {
                            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                                Text("Top Habits", style = MaterialTheme.typography.titleSmall)
                                analytics.topHabits.forEachIndexed { i, (name, pct) ->
                                    Row(verticalAlignment = Alignment.CenterVertically) {
                                        Text(
                                            "${i + 1}.", style = MaterialTheme.typography.titleMedium,
                                            color = MaterialTheme.colorScheme.primary,
                                        )
                                        Spacer(Modifier.width(8.dp))
                                        Column {
                                            Text(name, style = MaterialTheme.typography.titleSmall)
                                            Text(
                                                "${(pct * 100).roundToInt()}%",
                                                style = MaterialTheme.typography.labelSmall,
                                                color = MaterialTheme.colorScheme.onSurfaceVariant,
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            
            item {
                HeatMapPreviewCardInline(
                    heatMapData = analytics.heatMapData,
                    totalHabits = totalHabits,
                    onClick = onCalendarHeatMap,
                )
            }
        }
    }
}

@Composable
private fun HeatMapPreviewCardInline(
    heatMapData: Map<LocalDate, Int>,
    totalHabits: Int,
    onClick: () -> Unit,
) {
    Card(onClick = onClick, shape = RoundedCornerShape(16.dp), colors = CardDefaults.outlinedCardColors()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text("Heatmap Overview", style = MaterialTheme.typography.titleSmall)
            Spacer(Modifier.height(12.dp))
            DayOfWeek.entries.forEach { _ ->
                Row(horizontalArrangement = Arrangement.spacedBy(2.dp)) {
                    repeat(20) { col ->
                        val date = today.minus((19 - col) * 7, DateTimeUnit.DAY)
                        val count = heatMapData[date]
                        val alpha = if (count != null) (count.toFloat() / totalHabits).coerceIn(0.1f, 1f) else 0f
                        Box(
                            modifier = Modifier
                                .size(14.dp).clip(RoundedCornerShape(3.dp))
                                .background(
                                    if (alpha > 0f) MaterialTheme.colorScheme.primary.copy(alpha = alpha)
                                    else MaterialTheme.colorScheme.surfaceContainerHighest,
                                ),
                        )
                    }
                }
                Spacer(Modifier.height(2.dp))
            }
        }
    }
}



@Composable
private fun CalendarPage(
    habitWithAnalytics: HabitWithAnalytics,
    onBack: () -> Unit,
) {
    val doneDates = remember { habitWithAnalytics.statuses.map { it.date }.toSet() }
    val habitDays = habitWithAnalytics.habit.days

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Calendar", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←") 
                    }
                },
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(16.dp),
        ) {
            (5 downTo 0).forEach { offset ->
                val yearMonth = today.yearMonth
                var ym = yearMonth
                repeat(offset) { ym = ym.previousMonth() }
                item { MonthGridInline(month = ym, doneDates = doneDates, habitDays = habitDays) }
                item { Spacer(Modifier.height(20.dp)) }
            }
        }
    }
}

@Composable
private fun MonthGridInline(month: YearMonth, doneDates: Set<LocalDate>, habitDays: Set<DayOfWeek>) {
    val monthNum = month.month.ordinal + 1
    val yearInt = month.year
    val daysInMonth = daysInMonth(month.month, yearInt)
    val firstDayDow = LocalDate(yearInt, monthNum, 1).dayOfWeek

    Column {
        Text(
            "${month.month.name} $yearInt",
            style = MaterialTheme.typography.titleSmall.copy(fontWeight = FontWeight.Bold),
        )
        Spacer(Modifier.height(8.dp))

        
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceEvenly) {
            listOf("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun").forEach {
                Text(it, style = MaterialTheme.typography.labelSmall, color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
        Spacer(Modifier.height(4.dp))

        val totalCells = daysInMonth + firstDayDow.ordinal
        val rows = (totalCells + 6) / 7

        Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
            repeat(rows) { row ->
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceEvenly) {
                    repeat(7) { col ->
                        val dayNum = row * 7 + col - firstDayDow.ordinal + 1
                        if (dayNum in 1..daysInMonth) {
                            val date = LocalDate(yearInt, monthNum, dayNum)
                            val done = date in doneDates
                            val valid = date.dayOfWeek in habitDays && date <= today

                            Box(
                                modifier = Modifier
                                    .size(36.dp).clip(CircleShape)
                                    .background(if (done) MaterialTheme.colorScheme.primary else Color.Transparent),
                                contentAlignment = Alignment.Center,
                            ) {
                                Text(
                                    dayNum.toString(),
                                    style = MaterialTheme.typography.labelMedium,
                                    color = when {
                                        done -> MaterialTheme.colorScheme.onPrimary
                                        !valid -> MaterialTheme.colorScheme.onSurface.copy(alpha = 0.3f)
                                        else -> MaterialTheme.colorScheme.onSurface
                                    },
                                    fontWeight = if (date == today) FontWeight.Bold else FontWeight.Normal,
                                )
                            }
                        } else {
                            Spacer(Modifier.size(36.dp))
                        }
                    }
                }
            }
        }
    }
}


@Composable
private fun CalendarHeatMapPage(
    analytics: OverallAnalytics,
    onBack: () -> Unit,
) {
    var selectedDay by remember { mutableStateOf<LocalDate?>(null) }
    val totalHabits = mockHabits.size

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Heatmap", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←") 
                    }
                },
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(16.dp),
        ) {
            (1 downTo 0).forEach { yearOffset ->
                val year = today.year - yearOffset
                item {
                    Text(
                        "$year",
                        style = MaterialTheme.typography.titleSmall.copy(
                            fontWeight = FontWeight.Bold,
                            color = MaterialTheme.colorScheme.secondary,
                        ),
                        modifier = Modifier.padding(bottom = 8.dp),
                    )
                }

                (11 downTo 0).forEach { monthNum ->
                    val monthOrdinal = monthNum + 1
                    val m = Month.entries[monthNum]
                    val yearInt = year
                    val daysInMonth = daysInMonth(m, yearInt)
                    val firstDow = LocalDate(yearInt, monthOrdinal, 1).dayOfWeek
                    val ymon = YearMonth(yearInt, monthOrdinal)

                    if (ymon <= today.yearMonth) {
                        item {
                            Column(modifier = Modifier.padding(bottom = 12.dp)) {
                                Text(
                                    m.name.take(3),
                                    style = MaterialTheme.typography.labelSmall,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                                Spacer(Modifier.height(4.dp))

                                val totalCells = daysInMonth + firstDow.ordinal
                                val rows = (totalCells + 6) / 7

                                Column(verticalArrangement = Arrangement.spacedBy(3.dp)) {
                                    repeat(rows) { row ->
                                        Row(horizontalArrangement = Arrangement.spacedBy(3.dp)) {
                                            repeat(7) { col ->
                                                val dayNum = row * 7 + col - firstDow.ordinal + 1
                                                if (dayNum in 1..daysInMonth) {
                                                    val date = LocalDate(yearInt, monthOrdinal, dayNum)
                                                    val count = analytics.heatMapData[date]
                                                    val isSelected = selectedDay == date

                                                    Box(
                                                        modifier = Modifier
                                                            .size(if (isSelected) 26.dp else 18.dp)
                                                            .clip(RoundedCornerShape(if (isSelected) 14.dp else 4.dp))
                                                            .background(
                                                                when {
                                                                    isSelected -> MaterialTheme.colorScheme.tertiary
                                                                    count == null -> MaterialTheme.colorScheme.surfaceContainerLowest
                                                                    count == 0 -> MaterialTheme.colorScheme.surfaceContainerHighest
                                                                    else -> MaterialTheme.colorScheme.primary.copy(
                                                                        alpha = (count.toFloat() / totalHabits).coerceIn(0.15f, 1f),
                                                                    )
                                                                },
                                                            )
                                                            .clickable {
                                                                selectedDay = if (isSelected) null else date
                                                            },
                                                    )
                                                } else {
                                                    Spacer(Modifier.size(18.dp))
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    
    selectedDay?.let { date ->
        val habits = analytics.heatMapData[date]?.let { count ->
            mockHabits.take(count).map { it.title }
        } ?: emptyList()

        if (habits.isNotEmpty()) {
            AlertDialog(
                onDismissRequest = { selectedDay = null },
                title = { Text("${date.year}/${date.monthNumber}/${date.dayOfMonth}") },
                text = { Column { habits.forEach { Text("• $it") } } },
                confirmButton = { TextButton(onClick = { selectedDay = null }) { Text("Close") } },
            )
        }
    }
}


private val MONTH_DAYS = intArrayOf(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

private fun daysInMonth(month: Month, year: Int): Int {
    val base = MONTH_DAYS[month.ordinal]
    return if (month == Month.FEBRUARY && isLeapYear(year)) 29 else base
}

private fun isLeapYear(year: Int): Boolean = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)


private fun YearMonth.previousMonth(): YearMonth {
    val newMonth = if (month == Month.JANUARY) Month.DECEMBER else Month.entries[month.ordinal - 1]
    val newYear = if (month == Month.JANUARY) year - 1 else year
    return YearMonth(newYear, newMonth)
}
