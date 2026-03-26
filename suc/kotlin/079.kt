package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
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
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.filled.Notifications
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Star
import androidx.compose.material.icons.rounded.Home
import androidx.compose.material.icons.rounded.LocationOn
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            SmartHomeTheme {
                SmartHomeScreen()
            }
        }
    }
}

@Composable
fun SmartHomeTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = androidx.compose.material3.lightColorScheme(
            primary = Color(0xFF4A6572),
            onPrimary = Color.White,
            background = Color(0xFFF5F6F8),
            surface = Color.White,
            onSurface = Color(0xFF333333)
        ),
        content = content
    )
}

data class DeviceItem(
    val name: String,
    val status: String,
    val icon: ImageVector,
    val isActive: Boolean
)

@Composable
fun SmartHomeScreen() {
    Scaffold(
        bottomBar = { SmartHomeBottomBar() },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = 24.dp)
        ) {
            Spacer(modifier = Modifier.height(24.dp))
            HeaderSection()
            Spacer(modifier = Modifier.height(32.dp))
            EnvironmentSummary()
            Spacer(modifier = Modifier.height(32.dp))
            DevicesGrid()
        }
    }
}

@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "Welcome Home,",
                style = MaterialTheme.typography.bodyLarge,
                color = Color.Gray
            )
            Text(
                text = "Alex Johnson",
                style = MaterialTheme.typography.headlineMedium,
                fontWeight = FontWeight.Bold
            )
        }
        Box(
            modifier = Modifier
                .size(48.dp)
                .clip(CircleShape)
                .background(MaterialTheme.colorScheme.primary.copy(alpha = 0.1f)),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = Icons.Filled.AccountCircle,
                contentDescription = null,
                tint = MaterialTheme.colorScheme.primary,
                modifier = Modifier.size(32.dp)
            )
        }
    }
}

@Composable
fun EnvironmentSummary() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        EnvironmentCard(
            title = "Temperature",
            value = "24°C",
            subtitle = "Comfortable",
            color = Color(0xFFE3F2FD),
            textColor = Color(0xFF1565C0)
        )
        Spacer(modifier = Modifier.width(16.dp))
        EnvironmentCard(
            title = "Humidity",
            value = "45%",
            subtitle = "Normal",
            color = Color(0xFFE8F5E9),
            textColor = Color(0xFF2E7D32)
        )
    }
}

@Composable
fun EnvironmentCard(
    title: String,
    value: String,
    subtitle: String,
    color: Color,
    textColor: Color
) {
    Card(
        modifier = Modifier
            .height(100.dp),
        colors = CardDefaults.cardColors(containerColor = color),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Text(
                text = title,
                style = MaterialTheme.typography.labelMedium,
                color = textColor.copy(alpha = 0.8f)
            )
            Column {
                Text(
                    text = value,
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold,
                    color = textColor
                )
                Text(
                    text = subtitle,
                    style = MaterialTheme.typography.labelSmall,
                    color = textColor.copy(alpha = 0.7f)
                )
            }
        }
    }
}

@Composable
fun DevicesGrid() {
    val devices = listOf(
        DeviceItem("Living Room", "2 Lights On", Icons.Rounded.Home, true),
        DeviceItem("Smart Lock", "Locked", Icons.Filled.Lock, true),
        DeviceItem("Bedroom AC", "22°C", Icons.Filled.Star, false),
        DeviceItem("Router", "Online", Icons.Rounded.LocationOn, true),
        DeviceItem("Kitchen", "All Off", Icons.Filled.Info, false),
        DeviceItem("Corridor", "Motion Detected", Icons.Filled.Notifications, true)
    )

    Column {
        Text(
            text = "My Devices",
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold
        )
        Spacer(modifier = Modifier.height(16.dp))
        LazyVerticalGrid(
            columns = GridCells.Fixed(2),
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            contentPadding = PaddingValues(bottom = 16.dp)
        ) {
            items(devices) { device ->
                DeviceCard(device)
            }
        }
    }
}

@Composable
fun DeviceCard(device: DeviceItem) {
    var isChecked by remember { mutableStateOf(device.isActive) }

    val containerColor = if (isChecked) MaterialTheme.colorScheme.primary else Color.White
    val contentColor = if (isChecked) Color.White else Color.Black

    Card(
        colors = CardDefaults.cardColors(containerColor = containerColor),
        shape = RoundedCornerShape(20.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = if (isChecked) 8.dp else 2.dp),
        modifier = Modifier.height(140.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Surface(
                    shape = CircleShape,
                    color = if (isChecked) Color.White.copy(alpha = 0.2f) else Color(0xFFF0F0F0),
                    modifier = Modifier.size(36.dp)
                ) {
                    Box(contentAlignment = Alignment.Center) {
                        Icon(
                            imageVector = device.icon,
                            contentDescription = null,
                            tint = if (isChecked) Color.White else Color.Gray,
                            modifier = Modifier.size(20.dp)
                        )
                    }
                }
                Switch(
                    checked = isChecked,
                    onCheckedChange = { isChecked = it },
                    modifier = Modifier.size(width = 32.dp, height = 16.dp),
                    colors = SwitchDefaults.colors(
                        checkedThumbColor = Color.White,
                        checkedTrackColor = Color.White.copy(alpha = 0.4f),
                        uncheckedThumbColor = Color.Gray,
                        uncheckedTrackColor = Color.Transparent,
                        uncheckedBorderColor = Color.Gray
                    )
                )
            }

            Column {
                Text(
                    text = device.name,
                    style = MaterialTheme.typography.bodyMedium,
                    fontWeight = FontWeight.SemiBold,
                    color = contentColor
                )
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = if (isChecked) "On" else "Off",
                    style = MaterialTheme.typography.labelSmall,
                    color = contentColor.copy(alpha = 0.7f)
                )
            }
        }
    }
}

@Composable
fun SmartHomeBottomBar() {
    NavigationBar(
        containerColor = Color.White,
        tonalElevation = 8.dp,
        modifier = Modifier.clip(RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp))
    ) {
        NavigationBarItem(
            icon = { Icon(Icons.Filled.Home, contentDescription = null) },
            label = { Text("Home") },
            selected = true,
            onClick = { },
            colors = androidx.compose.material3.NavigationBarItemDefaults.colors(
                selectedIconColor = MaterialTheme.colorScheme.primary,
                selectedTextColor = MaterialTheme.colorScheme.primary,
                indicatorColor = MaterialTheme.colorScheme.primary.copy(alpha = 0.1f)
            )
        )
        NavigationBarItem(
            icon = { Icon(Icons.Filled.Star, contentDescription = null) },
            label = { Text("Scenes") },
            selected = false,
            onClick = { }
        )
        NavigationBarItem(
            icon = { Icon(Icons.Filled.Settings, contentDescription = null) },
            label = { Text("Settings") },
            selected = false,
            onClick = { }
        )
    }
}

@Preview(showBackground = true, heightDp = 800)
@Composable
fun DefaultPreview() {
    SmartHomeTheme {
        SmartHomeScreen()
    }
}