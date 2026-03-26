package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Face
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        WindowCompat.setDecorFitsSystemWindows(window, false)

        setContent {
            SideEffect {
                windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
            }

            val lightColors = lightColorScheme(
                primary = Color(0xFF212121),
                onPrimary = Color.White,
                secondary = Color(0xFFEEEEEE),
                onSecondary = Color.Black,
                background = Color.White,
                surface = Color.White,
                onBackground = Color(0xFF121212),
                onSurface = Color(0xFF121212)
            )

            MaterialTheme(colorScheme = lightColors) {
                TaskDashboardScreen()
            }
        }
    }
}

@Composable
fun TaskDashboardScreen() {
    Scaffold(
        containerColor = Color.White,
        topBar = { TopHeader() },
        floatingActionButton = {
            FloatingActionButton(
                onClick = {},
                containerColor = MaterialTheme.colorScheme.primary,
                contentColor = Color.White,
                shape = CircleShape
            ) {
                Icon(Icons.Default.Add, contentDescription = null)
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(horizontal = 24.dp)
        ) {
            Spacer(modifier = Modifier.height(16.dp))
            WelcomeSection()
            Spacer(modifier = Modifier.height(32.dp))
            CategorySelector()
            Spacer(modifier = Modifier.height(24.dp))
            RecentTasksList()
        }
    }
}

@Composable
fun TopHeader() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(top = 48.dp, start = 24.dp, end = 24.dp, bottom = 16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        IconButton(
            onClick = {},
            modifier = Modifier
                .size(48.dp)
                .background(Color(0xFFF5F5F5), CircleShape)
        ) {
            Icon(
                Icons.Default.Menu,
                contentDescription = null,
                tint = Color.Black
            )
        }

        IconButton(
            onClick = {},
            modifier = Modifier
                .size(48.dp)
                .background(Color(0xFFF5F5F5), CircleShape)
        ) {
            Icon(
                Icons.Default.Search,
                contentDescription = null,
                tint = Color.Black
            )
        }
    }
}

@Composable
fun WelcomeSection() {
    Column {
        Text(
            text = "Hello, Alex",
            fontSize = 32.sp,
            fontWeight = FontWeight.Bold,
            color = Color.Black
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = "You have 5 incomplete tasks today.",
            fontSize = 16.sp,
            color = Color.Gray
        )
    }
}

@Composable
fun CategorySelector() {
    val categories = listOf("All", "Work", "Personal", "Design")
    LazyRow(
        horizontalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        items(categories) { category ->
            val isSelected = category == "All"
            val backgroundColor = if (isSelected) Color(0xFF212121) else Color(0xFFF5F5F5)
            val textColor = if (isSelected) Color.White else Color.Black

            Box(
                modifier = Modifier
                    .clip(RoundedCornerShape(50))
                    .background(backgroundColor)
                    .padding(horizontal = 24.dp, vertical = 12.dp)
            ) {
                Text(
                    text = category,
                    color = textColor,
                    fontWeight = FontWeight.Medium
                )
            }
        }
    }
}

@Composable
fun RecentTasksList() {
    Column {
        Text(
            text = "Recent Tasks",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            item {
                TaskItem(
                    title = "Team Meeting",
                    time = "10:00 AM - 11:30 AM",
                    tag = "Work",
                    tagColor = Color(0xFFE3F2FD),
                    tagTextColor = Color(0xFF1565C0),
                    isChecked = true
                )
            }
            item {
                TaskItem(
                    title = "Design Review",
                    time = "02:00 PM - 03:00 PM",
                    tag = "Design",
                    tagColor = Color(0xFFF3E5F5),
                    tagTextColor = Color(0xFF7B1FA2),
                    isChecked = false
                )
            }
            item {
                TaskItem(
                    title = "Grocery Shopping",
                    time = "05:30 PM",
                    tag = "Personal",
                    tagColor = Color(0xFFE8F5E9),
                    tagTextColor = Color(0xFF2E7D32),
                    isChecked = false
                )
            }
            item {
                TaskItem(
                    title = "Read Documentation",
                    time = "08:00 PM",
                    tag = "Study",
                    tagColor = Color(0xFFFFF3E0),
                    tagTextColor = Color(0xFFEF6C00),
                    isChecked = false
                )
            }
            item {
                Spacer(modifier = Modifier.height(80.dp))
            }
        }
    }
}

@Composable
fun TaskItem(
    title: String,
    time: String,
    tag: String,
    tagColor: Color,
    tagTextColor: Color,
    isChecked: Boolean
) {
    Card(
        colors = CardDefaults.cardColors(
            containerColor = Color(0xFFFAFAFA)
        ),
        shape = RoundedCornerShape(20.dp),
        modifier = Modifier.fillMaxWidth(),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp)
    ) {
        Row(
            modifier = Modifier
                .padding(20.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Box(
                modifier = Modifier
                    .size(48.dp)
                    .clip(RoundedCornerShape(14.dp))
                    .background(Color.White),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = if (tag == "Personal") Icons.Default.Face else Icons.Default.DateRange,
                    contentDescription = null,
                    tint = Color.Black,
                    modifier = Modifier.size(24.dp)
                )
            }

            Spacer(modifier = Modifier.width(16.dp))

            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = title,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    color = if (isChecked) Color.Gray else Color.Black
                )
                Spacer(modifier = Modifier.height(4.dp))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        text = time,
                        fontSize = 12.sp,
                        color = Color.Gray
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Box(
                        modifier = Modifier
                            .clip(RoundedCornerShape(4.dp))
                            .background(tagColor)
                            .padding(horizontal = 6.dp, vertical = 2.dp)
                    ) {
                        Text(
                            text = tag,
                            fontSize = 10.sp,
                            fontWeight = FontWeight.Bold,
                            color = tagTextColor
                        )
                    }
                }
            }

            Checkbox(
                checked = isChecked,
                onCheckedChange = {},
                colors = CheckboxDefaults.colors(
                    checkedColor = Color.Black,
                    uncheckedColor = Color.Gray,
                    checkmarkColor = Color.White
                )
            )
        }
    }
}