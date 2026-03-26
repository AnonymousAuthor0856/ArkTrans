package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
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
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.LocationOn
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Notifications
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
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
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1. Enable Edge-to-Edge
        enableEdgeToEdge()

        // 2. Hide System Bars (Immersive Mode)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            BotanyApp()
        }
    }
}

// --- Data Models ---

data class Plant(
    val id: Int,
    val name: String,
    val scientificName: String,
    val location: String,
    val daysUntilWater: Int,
    val isHealthy: Boolean = true
)

data class Task(
    val id: Int,
    val title: String,
    val plantName: String,
    val icon: ImageVector,
    val urgency: String
)

// --- Color Palette (Strictly minimal/white based) ---

val BotanyWhite = Color(0xFFFFFFFF)
val BotanySurface = Color(0xFFFAFAFA) // Very slight grey for contrast
val BotanyTextPrimary = Color(0xFF1A1C19)
val BotanyTextSecondary = Color(0xFF757575)
val BotanyAccent = Color(0xFF2E5E4E) // Dark Green
val BotanyAccentLight = Color(0xFFE8F5E9)

private val BotanyColorScheme = lightColorScheme(
    primary = BotanyAccent,
    onPrimary = Color.White,
    background = BotanyWhite,
    surface = BotanyWhite,
    onBackground = BotanyTextPrimary,
    onSurface = BotanyTextPrimary,
)

// --- Main Composable ---

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BotanyApp() {
    MaterialTheme(colorScheme = BotanyColorScheme) {
        // Keep system bars hidden efficiently
        val window = (androidx.compose.ui.platform.LocalContext.current as? android.app.Activity)?.window
        if (window != null) {
            SideEffect {
                val controller = WindowCompat.getInsetsController(window, window.decorView)
                controller.hide(WindowInsetsCompat.Type.systemBars())
            }
        }

        Scaffold(
            containerColor = BotanyWhite,
            topBar = { BotanyTopBar() },
            floatingActionButton = {
                FloatingActionButton(
                    onClick = { /* No logic */ },
                    containerColor = BotanyTextPrimary,
                    contentColor = Color.White,
                    shape = CircleShape
                ) {
                    Icon(Icons.Default.Add, contentDescription = "Add Plant")
                }
            },
            bottomBar = { BotanyBottomBar() }
        ) { padding ->
            BotanyContent(padding)
        }
    }
}

@Composable
fun BotanyContent(padding: PaddingValues) {
    // Mock Data
    val tasks = listOf(
        Task(1, "Watering", "Monstera Deliciosa", Icons.Default.DateRange, "Today"),
        Task(2, "Fertilize", "Fiddle Leaf Fig", Icons.Default.Notifications, "Tomorrow"),
        Task(3, "Pruning", "Snake Plant", Icons.Default.Settings, "Next Week")
    )

    val plants = listOf(
        Plant(1, "Monstera", "Monstera deliciosa", "Living Room", 0),
        Plant(2, "Fiddle Leaf", "Ficus lyrata", "Bedroom", 2),
        Plant(3, "Snakey", "Sansevieria", "Hallway", 5),
        Plant(4, "Spider Plant", "Chlorophytum", "Kitchen", 1),
        Plant(5, "Peace Lily", "Spathiphyllum", "Bathroom", 3)
    )

    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .padding(padding)
            .background(BotanyWhite),
        contentPadding = PaddingValues(bottom = 80.dp)
    ) {
        // Section: Header
        item {
            Column(modifier = Modifier.padding(horizontal = 24.dp, vertical = 16.dp)) {
                Text(
                    text = "Good Morning,",
                    style = MaterialTheme.typography.bodyLarge,
                    color = BotanyTextSecondary
                )
                Text(
                    text = "My Jungle",
                    style = MaterialTheme.typography.displayMedium.copy(
                        fontWeight = FontWeight.Bold,
                        letterSpacing = (-1).sp
                    ),
                    color = BotanyTextPrimary
                )
            }
        }

        // Section: Tasks
        item {
            SectionHeader(title = "Pending Tasks")
            LazyRow(
                contentPadding = PaddingValues(horizontal = 24.dp),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                items(tasks) { task ->
                    TaskCard(task)
                }
            }
            Spacer(modifier = Modifier.height(32.dp))
        }

        // Section: Collection
        item {
            SectionHeader(title = "Your Collection")
        }

        items(plants) { plant ->
            PlantListItem(plant)
        }
    }
}

@Composable
fun SectionHeader(title: String) {
    Text(
        text = title,
        style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold),
        modifier = Modifier.padding(horizontal = 24.dp, vertical = 12.dp),
        color = BotanyTextPrimary
    )
}

@Composable
fun TaskCard(task: Task) {
    var isChecked by remember { mutableStateOf(false) }

    // Simple Card, no shadows, thin border
    Card(
        modifier = Modifier
            .width(160.dp)
            .height(180.dp)
            .clickable { isChecked = !isChecked },
        colors = CardDefaults.cardColors(containerColor = BotanySurface),
        shape = RoundedCornerShape(24.dp),
        border = if (isChecked) BorderStroke(2.dp, BotanyAccent) else BorderStroke(1.dp, Color(0xFFEEEEEE))
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Box(
                    modifier = Modifier
                        .size(40.dp)
                        .clip(CircleShape)
                        .background(if (isChecked) BotanyAccent else Color.White),
                    contentAlignment = Alignment.Center
                ) {
                    Icon(
                        imageVector = task.icon,
                        contentDescription = null,
                        tint = if (isChecked) Color.White else BotanyTextPrimary,
                        modifier = Modifier.size(20.dp)
                    )
                }
            }

            Column {
                Text(
                    text = task.title,
                    style = MaterialTheme.typography.bodyMedium.copy(fontWeight = FontWeight.Bold),
                    color = BotanyTextPrimary
                )
                Text(
                    text = task.plantName,
                    style = MaterialTheme.typography.bodySmall,
                    color = BotanyTextSecondary,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
                Spacer(modifier = Modifier.height(8.dp))

                // Status Chip
                Box(
                    modifier = Modifier
                        .clip(RoundedCornerShape(4.dp))
                        .background(if(isChecked) BotanyAccent else Color(0xFFE0E0E0))
                        .padding(horizontal = 6.dp, vertical = 2.dp)
                ) {
                    Text(
                        text = if(isChecked) "DONE" else task.urgency,
                        style = MaterialTheme.typography.labelSmall,
                        color = if(isChecked) Color.White else BotanyTextPrimary,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    }
}

@Composable
fun PlantListItem(plant: Plant) {
    var expanded by remember { mutableStateOf(false) }

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 24.dp, vertical = 8.dp)
            .clip(RoundedCornerShape(16.dp))
            .background(BotanySurface)
            .clickable { expanded = !expanded }
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        // "Image" Placeholder - Pure UI shapes
        Box(
            modifier = Modifier
                .size(56.dp)
                .clip(RoundedCornerShape(12.dp))
                .background(Color(0xFFEEEEEE)),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = Icons.Default.Favorite, // Using heart as abstract leaf/life symbol
                contentDescription = null,
                tint = if (plant.daysUntilWater == 0) BotanyAccent else Color(0xFFCCCCCC)
            )
        }

        Spacer(modifier = Modifier.width(16.dp))

        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = plant.name,
                style = MaterialTheme.typography.titleSmall.copy(fontWeight = FontWeight.Bold),
                color = BotanyTextPrimary
            )
            Text(
                text = plant.scientificName,
                style = MaterialTheme.typography.bodySmall,
                color = BotanyTextSecondary,
                fontStyle = androidx.compose.ui.text.font.FontStyle.Italic
            )

            if (expanded) {
                Spacer(modifier = Modifier.height(8.dp))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(
                        Icons.Default.LocationOn,
                        contentDescription = null,
                        modifier = Modifier.size(12.dp),
                        tint = BotanyTextSecondary
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text(
                        text = plant.location,
                        style = MaterialTheme.typography.labelSmall,
                        color = BotanyTextSecondary
                    )
                }
            }
        }

        Column(horizontalAlignment = Alignment.End) {
            if (plant.daysUntilWater == 0) {
                Icon(
                    imageVector = Icons.Default.Check,
                    contentDescription = "Water today",
                    tint = BotanyAccent,
                    modifier = Modifier.size(24.dp)
                )
                Text(
                    text = "Water",
                    style = MaterialTheme.typography.labelSmall,
                    color = BotanyAccent,
                    fontWeight = FontWeight.Bold
                )
            } else {
                Text(
                    text = "${plant.daysUntilWater} days",
                    style = MaterialTheme.typography.labelSmall,
                    color = BotanyTextSecondary
                )
            }
        }
    }
}

// --- Components ---

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BotanyTopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(top = 24.dp, start = 24.dp, end = 24.dp, bottom = 8.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        IconButton(
            onClick = { },
            modifier = Modifier
                .size(40.dp)
                .clip(CircleShape)
                .background(BotanySurface)
        ) {
            Icon(Icons.Default.Menu, contentDescription = "Menu", tint = BotanyTextPrimary)
        }

        IconButton(
            onClick = { },
            modifier = Modifier
                .size(40.dp)
                .clip(CircleShape)
                .background(BotanySurface)
        ) {
            Icon(Icons.Default.Search, contentDescription = "Search", tint = BotanyTextPrimary)
        }
    }
}

@Composable
fun BotanyBottomBar() {
    // Custom Minimal Bottom Bar
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(BotanyWhite)
            .padding(horizontal = 48.dp, vertical = 24.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        BotanyNavItem(Icons.Default.Home, true)
        BotanyNavItem(Icons.Default.DateRange, false)
        Spacer(modifier = Modifier.width(32.dp)) // Space for FAB
        BotanyNavItem(Icons.Default.Notifications, false)
        BotanyNavItem(Icons.Default.Settings, false)
    }
}

@Composable
fun BotanyNavItem(icon: ImageVector, isSelected: Boolean) {
    val alpha by animateFloatAsState(targetValue = if (isSelected) 1f else 0.4f)

    IconButton(onClick = {}) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = BotanyTextPrimary,
            modifier = Modifier.alpha(alpha)
        )
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewBotanyApp() {
    BotanyApp()
}